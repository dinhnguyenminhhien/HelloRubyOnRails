class CommentsController < ApplicationController
    before_action :find_article
	before_action :find_comment, only: [:edit, :update, :destroy]

	def create
	  @article = Article.find(params[:article_id])
	  @comment = @article.comments.create(comment_params)
	  @comment.user = current_user
	  
	  if @comment.save!
	    redirect_to article_path(@article)
	  else
	    flash[:error] = "Error saving the comment."
		redirect_to article_path(@article)
	  end
	end
	
	def edit
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
	end
	def update
	  @article = Article.find(params[:article_id])
	  @comment = @article.comments.find(params[:id])
	  
	  @comment.content = comment_params
	  if @comment.update(comment_params)
	    redirect_to article_path(@article)
	  else
	    render 'edit'
	  end
	end
	
	def destroy
	  @comment.destroy
	  redirect_to article_path(@article)
	end
	
	private
	def comment_params
	  params.require(:comment).permit(:content)
	end
	
	def find_article
	  @article = Article.find(params[:article_id])	
	end
	def find_comment
	  @article = Article.find(params[:article_id])
	end
	  
end
