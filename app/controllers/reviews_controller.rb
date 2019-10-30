class ReviewsController < ApplicationController
def create
  # authorize review # uncomment when required      # authorize user # uncomment when required
  @review = Review.new(review_params)
  if @review.save
    redirect_to dashboard_path
  else
    render :new
end

def edit
  # authorize review # uncomment when required      # authorize user # uncomment when required
  @review = Review.find(params[:id])
end

def update
  # authorize review # uncomment when required      # authorize user # uncomment when required
  @review = Review.find(params[:id])
  @review.update(reviews_params)
  redirect_to dashboard_path
end

def destroy
  # authorize review # uncomment when required      # authorize user # uncomment when required
  @review = Review.find(params[:id])
  @review.destroy
  redirect_to dashboard_path
end

private

def review_params
  params.require(:review).permit(:rating, :review_content)
end

end
