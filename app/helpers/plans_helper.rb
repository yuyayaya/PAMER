module PlansHelper

  def search_params(filter)
    if params[:search].present?
      return params[:search][filter.to_sym]
    else
      return ""
    end
  end
end
