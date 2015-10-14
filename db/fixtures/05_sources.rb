Source.seed(:id, :code,
  { id: 1, code: :headers, property_required: true, position: 6, condition_ids: (1..10).to_a },
  { id: 2, code: :body_as_json, property_required: true, position: 4, condition_ids: (1..13).to_a },
  { id: 3, code: :body_as_xml, property_required: true, position: 5, condition_ids: (1..10).to_a },
  { id: 4, code: :body_as_text, property_required: false, position: 3, condition_ids: (1..10).to_a },
  { id: 5, code: :status_code, property_required: false, position: 1, condition_ids: [1, 2, 7, 8, 9, 10] },
  { id: 6, code: :response_time, property_required: false, position: 2, condition_ids: [7, 8, 9, 10] }
)