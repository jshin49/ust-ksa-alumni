class EntranceGraduationYearValidator < ActiveModel::Validator
  def validate(user)
    if user.entrance_year > user.graduation_year
      user.errors[:graduation_year] << "should be after entrance year"
    end
  end
end
