class ProductsController < ApplicationController
  def index
    @filter = params[:filter]

    @products = Product.includes(:category).references(:category).order("categories.name", :name)
    @products = @products.where(on_sale: true) if @filter == "on_sale"
    @products = @products.where("products.created_at >= ?", 3.days.ago) if @filter == "new"
    @products = @products.page(params[:page]).per(8)

    @recently_viewed = recently_viewed_products
  end

  def show
    @product = Product.find(params[:id])
    remember_viewed_product(@product.id)
  end

  def search
    @keyword = params[:q].to_s.strip
    @category_id = params[:category_id]

    @products = Product.includes(:category).order(:name)
    if @keyword.present?
      term = "%#{Product.sanitize_sql_like(@keyword)}%"
      @products = @products.where("products.name LIKE :term OR products.description LIKE :term", term: term)
    end
    @products = @products.where(category_id: @category_id) if @category_id.present?
    @products = @products.page(params[:page]).per(8)
  end

  def clear_recently_viewed
    session.delete(:recently_viewed)
    redirect_to root_path, notice: "Your recently viewed products have been cleared."
  end

  private

  # Saves the last 4 viewed product ids in the session, newest first
  def remember_viewed_product(product_id)
    ids = session[:recently_viewed] || []
    ids.delete(product_id)
    ids.unshift(product_id)
    session[:recently_viewed] = ids.first(4)
  end

  def recently_viewed_products
    ids = session[:recently_viewed] || []
    Product.includes(:category).where(id: ids).sort_by { |product| ids.index(product.id) }
  end
end
