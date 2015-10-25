module ApplicationHelper
  def format_time(time)
    time.try(:strftime, "%d/%m/%Y at %H:%M")
  end
end
