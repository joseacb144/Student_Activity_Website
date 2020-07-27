require 'rqrcode'
class PurchasesController < ApplicationController
  layout 'main'
  before_action :authenticate_student!
  before_action :set_purchase, only: [:show, :destroy]

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.where(:student_id=>current_student.id)
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show



  qrcode = RQRCode::QRCode.new(@purchase.code)

  # NOTE: showing with default options specified explicitly
  @svg = qrcode.as_svg(
    offset: 0,
    color: '000',
    shape_rendering: 'crispEdges',
    module_size: 6,
    standalone: true
  )

  end

  # GET /purchases/new
  def new
    @product = Product.find(params[:product_id])

    if @product.discount &&  @product.discount > 0
      @total_paid = @product.price - ( @product.discount * @product.price)
    else
      @total_paid = @product.price 
    end

    if @product.type == "Book" && current_student.book_spent_total && current_student.book_spent_total >200
        @elegible_book_discount =  true

    end

    if @product.validity_months &&  @product.validity_months > 0
      @val_start_dt = Time.now
      @val_end_dt = Time.now + @product.validity_months.months
    end

    @purchase = @product.purchases.build(:product_id => params[:product_id], :student_id => current_student.id, :total_paid => @total_paid,
    :val_start_dt => @val_start_dt, :val_end_dt => @val_end_dt )


  end


  # POST /purchases
  # POST /purchases.json
  def create
    @product = Product.find(params[:product_id])
    @purchase = Purchase.new(purchases_params)
    if !current_student.has_credit_card
    
      redirect_to edit_student_registration_path, alert: "Please set your payment election."
    else
   

      respond_to do |format|
        if @purchase.save
          if @product.type == "Book"
            if @purchase.use_book_discount
              current_student.book_spent_total=@purchase.total_paid
              current_student.save
            else
              current_student.book_spent_total+=@purchase.total_paid
              current_student.save
            end
          end
          format.html { redirect_to product_purchase_url(@product, @purchase), notice: 'Purchase was successfully created.' }
          format.json { render :show, status: :created, location: @purchase }
        else
          format.html { render :new }
          format.json { render json: @purchase.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchases_params
      params.require(:purchase).permit(:val_start_dt, :val_end_dt, :total_paid, :product_id, :student_id, :use_book_discount)
    end
end
