module ApplicationHelper
  def bootstrap_flash_class(level)
    case level
    when :notice
      "flash alert alert-info"
    when :success
      "flash alert alert-success"
    when :error
      "flash alert alert-error"
    when :alert
      "flash alert alert-error"
    else
      "flash alert"
    end
  end
end
