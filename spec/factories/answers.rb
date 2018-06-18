FactoryBot.define do
  sequence :body do |n|
    "MyText#{n}"
  end

  factory :answer do     
    body "Answer"
    #question
    user
  end
  factory :invalid_answer, class: "Answer" do
    body nil
  end
end
