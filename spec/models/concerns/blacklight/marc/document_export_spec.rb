require 'spec_helper'

class MockClass
  include Blacklight::Marc::DocumentExport

  def to_marc
    fields = [
      { "100" => { "subfields" => [{ "a" => "Borja, Ronaldo I." }]}},
      { "245" => { "ind1" => " ", "ind2" => " ", "subfields" => [{ "a" => "Plasticity : ", "b" => "modeling & computation /", "c" => "Ronaldo I. Borja." }] } },
      { "260" => { "ind1" => " ", "ind2" => " ", "subfields" => [{ "a" => "Berlin :", "b" => "Springer,", "c" => "[2013]" }] } }
    ]
    MARC::Record.new_from_hash('fields' => fields)
  end
end

RSpec.describe Blacklight::Marc::DocumentExport do
  describe '#export_as_apa_citation_txt' do
    it 'takes publication information from the 260 field' do
      expect(MockClass.new.export_as_apa_citation_txt).to include('(2013)')
      expect(MockClass.new.export_as_apa_citation_txt).to include('Berlin: Springer.')
    end
  end
end
