# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderSortableTreeHelper
  module Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options
        node = options[:node]

        "
          <li data-node-id='#{ node.id }'>
            <div class='item'>
              <i class='handle'></i>
              #{ show_link }
              #{ controls }
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

      def controls
        node = options[:node]

        edit_path = h.url_for(:controller => options[:klass].pluralize, :action => :edit, :id => node)
        show_path = h.url_for(:controller => options[:klass].pluralize, :action => :show, :id => node)
        add_path = h.url_for(:controller => options[:klass].pluralize, :action => :new, :id => node)

        "<div class='btn-group pull-right controls'>
            #{ h.link_to h.glyph(:plus), add_path, class: 'btn btn-mini', data: { rel: 'tooltip', container: 'body', placement: 'bottom', delay: '200' }, title: 'Добавить дочерний сервис' if h.can? :create, node }
            #{ h.link_to h.glyph(:pencil), edit_path, class: 'btn btn-mini', data: { rel: 'tooltip', container: 'body', placement: 'bottom', delay: '200' }, title: 'Редактировать сервис' if h.can? :update, node }
            #{ h.link_to h.glyph(:trash), show_path, class: 'btn btn-mini btn-danger', data: { confirm: 'Вы уверены?', rel: 'tooltip', container: 'body', placement: 'bottom', delay: '200' }, title: 'Удалить жалобу' if h.can? :destroy, node }
          </div>"
      end

      def children
        unless options[:children].blank?
          "<ol class='nested_set'>#{ options[:children] }</ol>"
        end
      end

    end
  end
end

module RenderIncedentsTreeHelper
  module Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options
        node = options[:node]

        "
          <li data-node-id='#{ node.id }'>
            <div class='item'>
              <i class='handle'></i>
              #{ show_link }
            </div>
            #{ children }
          </li>
        "
      end

      def show_link
        node = options[:node]
        h.render partial: 'tree_item', locals: { incedent: node }
      end

      def controls
      end

      def children
        unless options[:children].blank?
          "<ol class='nested_set'>#{ options[:children] }</ol>"
        end
      end

    end
  end
end