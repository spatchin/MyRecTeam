class CommentsController < ApplicationController
  before_action :set_and_authorize_resource, only: [:update, :destroy]
  before_action :authorize_resource, only: [:create]

  def create
    @comment = Comment.new(resource_params)
    @comment.commenter = current_user

    if !@comment.save
      flash[:alert] = 'Comment could not be saved.'
    end

    redirect_to @comment.commentable
  end

  def update
    if @comment.update(resource_params)
      flash[:notice] = 'Comment was successfully updated.'
    else
      flash[:alert] = 'Comment could not be updated.'
    end

    redirect_to @comment.commentable
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable
  end

  private

  def resource_params
    params.require(:comment).permit(:commentable_type, :commentable_id, :comment, :title, :commenter)
  end

  def set_and_authorize_resource
    authorize @comment = Comment.find(params[:id])
  end
end

