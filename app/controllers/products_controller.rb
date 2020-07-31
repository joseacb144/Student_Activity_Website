class ProductsController < ApplicationController
  layout 'main'
  before_action :authenticate_student!
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_type, except: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    logger.info "type "+params[:type].to_s
    if params[:type]=='Book'
      @products = type_class.books
    elsif params[:type]=='Meal'
      @products = type_class.meals
    elsif params[:type]=='BusTicket'
      @products = type_class.bus_tickets
    elsif params[:type]=='Admin'
      @products = type_class.all
    else
      flash[:alert] ="Invalid URL"
      redirect_to student_root_path
    end
  end


  def search
    respond_to do |format|
      @products = type_class.books
       if !params[:title].blank? || !params[:isbn].blank?  || !params[:author].blank?

        if !params[:title].blank?
          title = params[:title].html_safe
          @products = @products.where(:title => /#{title}/)
        end

        if !params[:isbn].blank?
          isbn = params[:isbn].html_safe
           @products =@products.where(:isbn => /#{isbn}/)
        end

        if !params[:author].blank?
          author = params[:author].html_safe
           @products =@products.where(:author => /#{author}/)
        end
        

        logger.info "Found "+@products.size.to_s
      end
     
        format.json {@products}
        format.js { render json: @products.to_json}
        format.html{ render :inline => "<br>"}
      end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    logger.info "type "+params[:_type].to_s
    @product = type_class.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    if params[:product][:type]=='Book'
      @product = Book.new(book_params)
    end

    if params[:product][:type]=='Meal'
      @product = Meal.new(meal_params)
    end
    if params[:product][:type]=='BusTicket'
      @product = BusTicket.new(bus_ticket_params)
    end


    respond_to do |format|
      if @product.save
        format.html { redirect_to edit_product_url(@product), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_type
      @type = type
    end

    def type
      
      Product.types.include?(params[:type]) ? params[:type] : "Product"
    
    end

    def type_class
      type.constantize
    end

    def set_product
      @product = Product.find(params[:id])
      @type = @product.type
    end
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:validity_months, :discount, :price, :type, @type.constantize.attribute_names.map(&:to_sym))
    end
     def book_params
      params.require(:product).permit(:validity_months, :discount, :price, :type, Book.attribute_names.map(&:to_sym))
    end
     def meal_params
      params.require(:product).permit(:validity_months, :discount, :price, :type, Meal.attribute_names.map(&:to_sym))
    end
     def bus_ticket_params
      params.require(:product).permit(:validity_months, :discount, :price, :type, BusTicket.attribute_names.map(&:to_sym))
    end
end
