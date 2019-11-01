class ReviewsController < ApplicationController
def create
  @review = Review.new(review_params)
  @rental = Rental.find(params[:rental_id])
  @review.rental = @rental
  authorize @review
  if @review.save
    redirect_to rental_path(@rental)
  else
    render :create
  end
end

def edit
  @review = Review.find(params[:id])
  authorize @review
end

def update
  @review = Review.find(params[:id])
  authorize @review
  @review.update(reviews_params)
  redirect_to review_path
end

def destroy
  @review = Review.find(params[:id])
  authorize @review
  @review.destroy
  redirect_to review_path
end

private

def review_params
  params.require(:review).permit(:rating, :review_content)
end

end
