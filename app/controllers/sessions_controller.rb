class SessionsController <  Devise::SessionsController

  layout 'application'
  def index

    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    #
    if request.xhr?  #if an ajax request...
      logger.info "remote"
      flash[:notice] = nil
    end
 
     respond_with(resource, serialize_options(resource))
    
  end

  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    #
    if request.xhr?  #if an ajax request...
      logger.info "remote"
      flash[:notice] = nil
    end
 
     respond_with(resource, serialize_options(resource))
  end

  def about

  end

  

  private

  def setup_navigation
 
  end


end
