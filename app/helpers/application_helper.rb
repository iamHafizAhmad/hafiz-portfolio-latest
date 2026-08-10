module ApplicationHelper
  # Renders a dark, macOS-terminal-style window around a block of code.
  # Usage:
  #   <%= terminal_window("animal.rb") do %>
  #     class Animal
  #       ...
  #     end
  #   <% end %>
  def terminal_window(title = "code.rb", &block)
    code = capture(&block)

    content_tag :div, class: "rounded-xl overflow-hidden border border-white/10 shadow-lg shadow-black/40 bg-[#0d1117] mt-4" do
      header = content_tag :div, class: "flex items-center gap-2 px-4 py-2.5 bg-white/5 border-b border-white/10" do
        dots = content_tag(:span, "", class: "w-3 h-3 rounded-full bg-red-500/80") +
               content_tag(:span, "", class: "w-3 h-3 rounded-full bg-yellow-500/80") +
               content_tag(:span, "", class: "w-3 h-3 rounded-full bg-green-500/80")
        dots + content_tag(:span, title, class: "ml-3 text-xs text-gray-400 font-mono")
      end

      body = content_tag :pre, class: "p-4 overflow-x-auto text-[13px] leading-relaxed" do
        content_tag(:code, code, class: "text-gray-200 font-mono whitespace-pre")
      end

      header + body
    end
  end
end
