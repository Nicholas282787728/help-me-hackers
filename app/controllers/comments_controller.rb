class CommentsController < ApplicationController
  before_filter :find_comment
  before_filter :login_required, :only => [:create, :edit, :update, :destroy]

  def edit
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.correct = true if params[:commit_and_solve]

    if @comment.save
      flash[:notice] = t('Comment was successfully created')

      # tweet
      task = @comment.task
      reply(task.user.login, @comment.description, "#{task_url(task)}#comment-#{@comment.id}")

      redirect_to task_path(@comment.task)
    else
      render :action => :new
    end
  end

  def update
    if @comment.update_attributes(params[:comment])
      flash[:notice] = t('Comment was successfully updated')
      redirect_to task_path(@comment.task)
    else
      render :action => :edit
    end
  end

  def destroy
    task = @comment.task
    if @comment.destroy
      flash[:notice] = t('Comment was successfully deleted')
      redirect_to task_path(task)
    else
      flash[:notice] = t('Comment was not deleted')
      redirect_to task_path(task)
    end
  end

  private
  def find_comment
    @comment = Comment.find(params[:id]) if params[:id]
  end
end
