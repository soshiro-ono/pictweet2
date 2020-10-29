class TweetsController < ApplicationController

  before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search]


  def index
    # @tweets = Tweet.includes(:user)#n+1問題解決のためincludesを使う
    @tweets = Tweet.includes(:user).order("created_at DESC")

  end

  def new
    @tweet = Tweet.new #このニューはどういう意味？#、ビューが@tweet
  end

  def create
    Tweet.create(tweet_params)#privateのtweet_params
  end

  def destroy #Tweet.find(params[:id])の意味はデータテーブルから指定されたidのデータを1つ取り出してきている。どこで指定？
    tweet = Tweet.find(params[:id]) #@がいるときといらない時の違いは何？ ビューに情報を受け渡すかどうか？
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)#privateのtweet_params
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end
  # def search
  #   @tweets = Tweet.search(params[:keyword])
  # end

  private
  def tweet_params
    #params.require(:tweet).permit(:name, :image, :text).merge(user_id: current_user.id)#params.require(:モデル名)で取得したい情報を指定する#permit(:キー名, :キー名)  # 取得したいキーを指定する
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)

  end

  def set_tweet
    @tweet = Tweet.find(params[:id])#edit showの処理をまとめている。この先、if文などでbeforeを先に定義しないと表示できない部分はあるが今回は大丈夫。例えばshowアクションが動いた時にset_tweetが読み込まれるイメージ。
  end

  def move_to_index
    unless user_signed_in?#サインインしてなかったら
      redirect_to action: :index#リダイレクト先であるインデックスページに飛んでね
    end
  end

end

