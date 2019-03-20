module PagesHelper
  def flash_class(level)
    case level
    when 'notice'
    'alert alert-success'
    when 'success'
    'alert alert-success'
    when 'error'
    'alert alert-danger'
    when 'alert'
    'alert alert-danger'
    end
  end
end
