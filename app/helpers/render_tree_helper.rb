# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderTreeHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]
        "
          <li>
            <div class='item'>
              #{ show_link }
            </div>
            #{ children }
          </li>
        "
      end

      def show_link
        node = options[:node]
        ns   = options[:namespace]
        url  = h.url_for(ns + [node])
        title_field = options[:title]

        "<h4>#{ h.link_to(node.send(title_field), url) }</h4>"
      end

      def children
        unless options[:children].blank?
          "<ol>#{ options[:children] }</ol>"
        end
      end

    end
  end
end

module RenderDashboardTreeHelper
  class Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options

        node = options[:node]
        result = "<li><div class='item'>"
        result += show_link
        result += "</div>" if node.have_childs?
        result += children.to_s
        result += "</li>"
        result
      end

      def show_link
        node = options[:node]
        title_field = options[:title]

        result = "<h4 onclick='$(\"#service-#{node.id}\").toggle();'>"
        result += node.send(title_field)
        result += '<div class="pull-right">'+(h.glyph(:plus))+'</div>' unless node.have_childs?

        unless node.have_childs?
          tp = 0
          result += "</div><ol><li><div class='item' id='service-#{node.id}' style='display : none; '><table class='table table-very-condensed table-bordered table-hover'>"

          node.service_classes.each do |sclass|
            if tp != sclass.type_id
              if tp != 0
                result += "</tr>"
              end
              result += "<tr>"
              result += "<td>"
              result += h.lbl sclass.type.name
              result += "</td>"
              tp = sclass.type_id
            end

            result += "<td align='center'>"
            result += h.link_to (h.image_tag 'priority'+sclass.priority_id.to_s+'.gif', data: { rel: 'tooltip', placement: 'bottom', container: 'body', delay: '200' }, title: sclass.priority.name), h.add_incedent_by_class_path(sclass)
            result += "</td>"
          end

          result += "</tr></table></div></li></ol>"
        end

        result += "</h4>"
        result
      end

      def children
        unless options[:children].blank?
          "<ol>#{ options[:children] }</ol>"
        end
      end

    end
  end
end