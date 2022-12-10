class Follow < ApplicationRecord
  
  belongs_to :follower, class_name: "User" #class_nameでUserのモデルを継承
  belongs_to :followed, class_name: "User"
end
