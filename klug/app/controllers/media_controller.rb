class MediaController < ApplicationController
  devise_token_auth_group :member, contains: [:user, :admin]
  before_action :authenticate_member!   #, except: :translate

  def index
    respond_with Medium.all
  end

  def create
    respond_with Medium.create(post_params)
  end

  def show
    respond_with Medium.find(params[:id])
  end

  def update
    @medium = Medium.find(params[:id])
    @medium.update(post_params)
    respond_with @medium
  end

  def usertranslation
    @medium = Medium.find(params[:id])

    @medium.translation = ActiveRecord::Base.connection.select_all(
      'SELECT w.id as wordId
             ,w.word
             ,w.translation
             ,tm
             ,(tm::numeric + cnt::numeric / 3)::integer - 1 as "time"
             ,(tm::numeric + cnt::numeric / num::numeric *  + interv::numeric)::integer as "time2"
       FROM words w
       LEFT JOIN (SELECT * FROM userwords WHERE user_id = ' + current_user.id.to_s + ') u ON w.id = u.word_id
       INNER JOIN (SELECT lower(word) as word
                        ,row_number() over(w) cnt
                        ,tm
                        ,nxt_tm - tm as interv
                        ,num
                   FROM
                   (
                     SELECT tm
                           ,nxt_tm
                           ,regexp_split_to_table(regexp_replace(txt, \'[^\\w\\s]\', \'\', \'g\'), \'\\s+\') word
                           ,length(regexp_replace(txt, \'[^\\s]\', \'\', \'g\')) num
                     FROM
                     (
                       SELECT tm, txt, lead(tm) over () as nxt_tm
                       FROM
                       (
                         SELECT b.a[1]::integer * 60  + b.a[2]::integer tm, trim(b.a[3]) txt
                         FROM 
                         (
                           SELECT regexp_matches(\'' + @medium.transcript.gsub(/[^A-Za-z0-9\s<>:]+/, '') + '\', \'<(\\d{1,2}):(\\d{2})>(.[^<]*)\', \'g\') a
                         ) b
                       ) c
                       ORDER BY tm
                     ) d
                   ) e
                   WINDOW w as (partition by tm)
                  ) f ON w.word = f.word
                  
        WHERE (w.level >= ' + current_user.level.to_s + ' OR u.word_id is not null)
        AND w.active = \'TRUE\'
        ORDER BY time, w.rank')
    
    respond_with @medium, methods: [:translation], :except => [:transcript, :created_at, :updated_at]
  end


  private
  def post_params
    params.require(:medium).permit(:name, :mediatype, :url, :identifier, :transcript)
  end
end
