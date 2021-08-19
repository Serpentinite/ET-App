module ApplicationHelper
    def bootstrap_alert(key)
        case key
        when "alert"
          "warning"
        when "notice"
          "success"
        when "error"
          "danger"
        when "succeed"
          "primary"
        end
    end
end

