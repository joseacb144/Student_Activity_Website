class SessionsController <  Devise::SessionsController

  layout 'application'
  def index

    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    #
    logger.info "remote"

 
     respond_with(resource, serialize_options(resource))
    
  end

  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    #

    logger.info "remote"
    
 
     respond_with(resource, serialize_options(resource))
  end

  def create
    super
    logger.info "inside create"
  end

  def about

  end

  

  private

  def setup_navigation
 
  end


end
