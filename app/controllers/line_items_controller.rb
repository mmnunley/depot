class LineItemsController < ApplicationController
  skip_before_filter :authorize, :only => :create
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    #This will find or create a cart based on applications controller method
    @cart = current_cart
    #We use params to get the product ID from the request
    #This is stored locally as no need to let view see it
    product = Product.find(params[:product_id])
    
    #Adds an item to the cart using the "add_product" 
    #function in the "cart.rb" file.
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(store_url) }
        #.js is added to stop the create action from 
        #redirecting to the index display if the request is 
        #from javascript
        format.js { @current_item = @line_item }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @cart = current_cart
    #We use params to get the product ID from the request
    #This is stored locally as no need to let view see it
    product = Product.find(params[:product_id])
    
    #Adds an item to the cart using the "add_product" 
    #function in the "cart.rb" file.
    @line_item = @cart.delete_product(product.id)

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to(store_url) }
        format.js { @current_item = @line_item }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    # @line_item = LineItem.find(params[:id])
    # @line_item.destroy

    @cart = current_cart
    #We use params to get the product ID from the request
    #This is stored locally as no need to let view see it
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    
    #Adds an item to the cart using the "add_product" 
    #function in the "cart.rb" file.


    respond_to do |format|
      format.html { redirect_to(store_url) }
      format.js { @current_item = @line_item }
      format.json { head :no_content }
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def decrease
    @cart = current_cart
    @line_item = @cart.decrease(params[:id])

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(store_url) }
        format.js   { @current_item = @line_item }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def increase
    @cart = current_cart
    @line_item = @cart.increase(params[:id])

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(store_url) }
        format.js   { @current_item = @line_item }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

end
