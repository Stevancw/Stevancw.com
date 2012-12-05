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

      # def my_pages
      #   Page.find_all.select { |p| p.flagged_as?('wow') }
      # end
    #   def my_pages
    #     Page.find_all.select do |page|
    #       page.category
    #   end
    end

    # Add new routes here.
  end
end
