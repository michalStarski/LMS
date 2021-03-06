class BookstoresController < ApplicationController
    
    before_action :authenticate_user!

    def index
        @bookstores = Bookstore.all
    end
    def new 
        @collections = Collection.all
    end
    def create
        @new_bookstore = Bookstore.new(bookstore_params)
        @new_bookstore.save

        redirect_to bookstores_path
    end
    
    def show
       @bookstore = Bookstore.find(params[:id])
       # Pass bookstore coordinates to javascript
       gon.push({
           :latitude => @bookstore.latitude,
           :longitude => @bookstore.longitude,
           :name => @bookstore.name
       })
    end

    def edit
        @bookstore = Bookstore.find(params[:id])
        @collections = Collection.all
    end

    def update
        @bookstore = Bookstore.find(params[:id])
        if @bookstore.update_attributes(bookstore_params) 
            render file: '/app/views/books/edit_success.html.erb'
        else
            render file: '/app/views/books/edit_fail.html.erb'
        end
    end

    def destroy
        @bookstore = Bookstore.find(params[:id])
        if @bookstore.destroy
            render file: '/app/views/books/delete_success.html.erb'
        else
            render file: '/app/views/books/delete_fail.html.erb'
        end
    end

    def get_collection_name(id)
        if id == nil
           "None"
        else
            Collection.find(id).name
        end
    end

    helper_method :get_collection_name

    private
        def bookstore_params
            params.require(:bookstore).permit(:name, :collection_id, :longitude, :latitude)
        end
end
