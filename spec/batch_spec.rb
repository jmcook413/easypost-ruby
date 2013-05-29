require 'spec_helper'

describe EasyPost::Batch do

  describe '#create' do
    it 'creates a batch object' do
      from_address = EasyPost::Address.create( 
        :name => "Benchmark Merchandising", 
        :street1 => "329 W 18th Street", 
        :city => "Chicago", 
        :state => "IL", 
        :zip => "60616" 
      ) 
      to_address = EasyPost::Address.create( 
        :street1 => "902 Broadway 4th Floor", 
        :city => "New York", 
        :state => "NY", 
        :zip => "10010" 
      )       
      parcel = EasyPost::Parcel.create( 
        :weight => 7.2, 
        :height => 2, 
        :width => 7.5, 
        :length => 10.5 
      )
      
      # shipment = EasyPost::Shipment.create(
      #   :to_address => to_address,
      #   :from_address => from_address,
      #   :parcel => parcel
      # )
      batch = EasyPost::Batch.create(
        [
          { 
            :from_address => from_address,
            :to_address   => to_address,
            :parcel       => parcel
          },
          { 
            :from_address => from_address,
            :to_address   => to_address,
            :parcel       => parcel,
            :reference    => 'refnum9173'
          }
        ]
      )
      expect(batch).to be_an_instance_of(EasyPost::Batch)
      expect(batch.status[:created]).to equal(2)
      expect(batch.shipments.length).to equal(2)      
    end
  end

end
