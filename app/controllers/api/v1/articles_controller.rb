class Api::V1::ArticlesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :find_article, only: [:show, :update, :destroy]
    def index
        @article = Article.all
        render json: {status: 'SUCCESS', message:'Loaded articles', data: @article},status: :ok
    end

    def show
        render json: {status: 'SUCCESS', message:'Loaded articles', data: @article},status: :ok
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            render json: {status: 'SUCCESS', message:'Saved article', data: @article},status: :ok
        else
            render json: {status: 'ERROR', message:'Article not saved', data: @article.errors},status: :ok
        end
    end
    def update
        if @article
            @article.update(article_params)
            render json: {status: 'SUCCESS', message:'updated article', data: @article},status: :ok
        else
            render json: {status: 'ERROR', message:'Article not updated', data: @article.errors},status: :ok
        end
    end

    def destroy
        if @article
            @article.destroy
            render json: {status: 'SUCCESS', message:'destory article', data: @article},status: :ok
        else
            render json: {status: 'ERROR', message:'Article not destroy', data: @article.errors},status: :ok
        end
    end
    
    private

    def find_article
        @article = Article.find(params[:id])
    end
    def article_params
        params.require(:article).permit(:title, :body, :user_id)
    end
  
end
