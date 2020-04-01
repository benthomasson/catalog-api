class PortfolioPolicy < ApplicationPolicy
  def create?
    rbac_access.create_access_check(Portfolio)
  end

  alias copy? create?

  def destroy?
    rbac_access.destroy_access_check
  end

  def show?
    rbac_access.read_access_check
  end

  def update?
    rbac_access.update_access_check
  end

  alias share? update?
  alias unshare? update?

  # def set_approval?
  #   # TODO: Add "Approval Administrator" check as &&
  #   rbac_access.update_access_check
  # end

  class Scope < Scope
    def resolve
      if access_scopes.include?('admin')
        scope.all
      elsif access_scopes.include?('group')
        ids = Catalog::RBAC::AccessControlEntries.new(@user_context.group_uuids).ace_ids('read', Portfolio)
        scope.where(:id => ids)
      elsif access_scopes.include?('user')
        scope.by_owner
      else
        Rails.logger.error("Error in scope search for #{scope.table_name}")
        Rails.logger.error("Scope does not include admin, group, or user. List of scopes: #{access_scopes}")
        raise Catalog::NotAuthorized, "Not Authorized for #{scope.table_name}"
      end
    end
  end
end
