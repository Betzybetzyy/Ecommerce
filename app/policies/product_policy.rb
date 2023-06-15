class ProductPolicy < BasePolicy
    def edit
        record.owner?
    end

    def update
        record.user_id == Current.user.id
    end

    def destroy
        record.user_id == Current.user.id
    end
end