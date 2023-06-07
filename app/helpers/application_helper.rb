# frozen_string_literal: true

# Top-level ApplicationHelper mixed in to all views
module ApplicationHelper
  def status_badge(color = :green)
    colors =
      case color
      when :green then 'text-green-400 bg-green-400/10'
      when :yellow then 'text-amber-400 bg-amber-400/10'
      else 'text-slate-400 bg-slate-400/10'
      end

    content_tag(:div, class: "flex-none rounded-full p-1 #{colors}") do
      content_tag(:div, nil, class: 'h-1.5 w-1.5 rounded-full bg-current')
    end
  end

  def status_indicator(manuscript)
    case manuscript.status
    when 'WITH_AUTHOR'
      status_badge(:yellow)
    else
      status_badge(:green)
    end
  end
end
