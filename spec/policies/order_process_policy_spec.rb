describe OrderProcessPolicy do
  let(:order_process) { create(:order_process) }
  let(:user_context) { UserContext.new("current_request", "params") }
  let(:rbac_access) { instance_double(Catalog::RBAC::Access) }

  let(:subject) { described_class.new(user_context, order_process) }

  before do
    allow(Catalog::RBAC::Access).to receive(:new).with(user_context, order_process).and_return(rbac_access)
  end

  describe "#show?" do
    it "returns true" do
      expect(rbac_access).to receive(:read_access_check).and_return(true)
      expect(subject.show?).to eq(true)
    end
  end

  describe "#create?" do
    it "returns true" do
      expect(rbac_access).to receive(:create_access_check).with(OrderProcess).and_return(true)
      expect(subject.create?).to eq(true)
    end
  end

  describe "#update?" do
    it "returns true" do
      expect(rbac_access).to receive(:update_access_check).and_return(true)
      expect(subject.update?).to eq(true)
    end
  end

  describe "#destroy?" do
    it "returns true" do
      expect(rbac_access).to receive(:destroy_access_check).and_return(true)
      expect(subject.destroy?).to eq(true)
    end
  end

  describe "#user_capabilities" do
    it "returns user capabilities" do
      expect(rbac_access).to receive(:read_access_check).and_return(true)
      expect(rbac_access).to receive(:create_access_check).with(OrderProcess).and_return(true)
      expect(rbac_access).to receive(:destroy_access_check).and_return(true)
      expect(rbac_access).to receive(:update_access_check).and_return(true)
      expect(subject.user_capabilities).to eq(
        "create"  => true,
        "destroy" => true,
        "show"    => true,
        "update"  => true
      )
    end
  end
end
