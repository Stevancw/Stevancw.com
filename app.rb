# Use the app.rb file to load Ruby code, modify or extend the models, or
# do whatever else you fancy when the theme is loaded.

module Nesta
  class App
    # Uncomment the Rack::Static line below if your theme has assets
    # (i.e images or JavaScript).
    #
    # Put your assets in themes/bootstrap/public/bootstrap.
    #
    use Rack::Static, :urls => ["/bootstrap"], :root => "themes/bootstrap/public"

    not_found do
      haml :error
    end

    helpers do
      def container
        if @page && @page.flagged_as?('fluid')
          'container-fluid'
        else
          'container'
        end
      end

      def latest_articles(count = 8)
        Nesta::Page.find_articles[0..count - 1]
      end

      
    #Trying to list by metadata (delete if you figure it out)
      # def my_category_pages
      #   Page.find_all.select { |p| p.flagged_as?('shown-on-blog') }
      # end

      def my_pages
        Page.find_all.select { |p| p.flagged_as?('medicine') }
      end

      def pages
        in_category = Page.find_all.select do |page|
        page.date.nil? && page.categories.include?(self)
      end
        in_category.sort do |x, y|
        by_priority = y.priority(path) <=> x.priority(path)
          if by_priority == 0
            x.link_text.downcase <=> y.link_text.downcase
          else
            by_priority
          end
        end
      end


      def categories
        paths = category_strings.map { |specifier| specifier.sub(/:-?\d+$/, '') }
        pages = valid_paths(paths).map { |p| Page.find_by_path(p) }
        pages.sort do |x, y|
        x.link_text.downcase <=> y.link_text.downcase
        end
      end

    #   def my_pages
    #     Page.find_all.select do |page|
    #       page.category
    #   end
    end

    # Add new routes here.
  end
end
