module Devise
  module Controllers
    module ScopedViews
      extend ActiveSupport::Concern

      module ClassMethods
        def scoped_views?
          defined?(@scoped_views) ? @scoped_views : Devise.scoped_views
        end

        def scoped_views=(value)
          @scoped_views = value
        end
      end

    protected

      # Render a view for the specified scope. Turned off by default.
      # Accepts just :controller as option.
      def render_with_scope(action, path=self.controller_path, options={})
        if self.class.scoped_views?
          begin
            render({:template => "#{devise_mapping.scoped_path}/#{path.split("/").last}/#{action}"}.merge(options))
          rescue ActionView::MissingTemplate
            render({:template => "#{path}/#{action}"}.merge(options))
          end
        else
          render({:template => "#{path}/#{action}"}.merge(options))
        end
      end
    end
  end
end
