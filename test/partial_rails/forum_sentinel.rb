class ForumSentinel < Sentinel::Sentinel
  def indexable?
    current_user?
  end
  
  def creatable?
    current_user_admin?
  end
  
  def reorderable?
    current_user_admin?
  end
  
  def viewable?
    self.forum.public? || (current_user? && self.forum.members.include?(self.current_user)) || current_user_admin?
  end
  
  def editable?
    (current_user? && self.forum.owner == self.current_user) || current_user_admin?
  end
  
  def destroyable?
    editable?
  end
  
  private
  
  def current_user?
    !self.current_user.nil?
  end
  
  def current_user_admin?
    current_user? && self.current_user.admin?
  end
end