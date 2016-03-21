class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authorize_ownership, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to @comment.story, notice: 'Comment created.'
    else
      redirect_to stories_path, alert: 'Comment creation failed.'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @story, notice: 'Comment updated.'
    else
      redirect_to @story, alert: 'Comment update failed.'
    end
  end

  def destroy
    @comment.destroy
    redirect_to @story, notice: 'Comment deleted.'
  end

  #-------------------------------
  private

  def find_comment
    @comment = Comment.find(params[:id])
    @story = @comment.story
  end

  def authorize_ownership
    if @comment.user != current_user
      redirect_to stories_path, alert: 'You do not have required permissions.'
    end
  end

  def comment_params #strong params
    params.require(:comment).permit(:story_id, :content)
  end
end