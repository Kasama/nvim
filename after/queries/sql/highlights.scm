(comment) @comment

; (function_call
;     function: (identifier) @function)

(identifier) @variable

[
  (keyword_null)
  (keyword_true)
  (keyword_false)
] @constant.builtin

[
  (keyword_smallserial)
  (keyword_serial)
  (keyword_bigserial)
  (keyword_smallint)
  (keyword_int)
  (keyword_bigint)
  (keyword_decimal)
  (keyword_numeric)
  (keyword_real)
  (double)
  (keyword_money)
  (keyword_char)
  (keyword_varchar)
  (keyword_text)
  (keyword_uuid)
  (keyword_json)
  (keyword_jsonb)
  (keyword_xml)
  (keyword_bytea)
  (keyword_date)
  (keyword_datetime)
  (keyword_timestamp)
  (keyword_timestamptz)
  (keyword_geometry)
  (keyword_geography)
  (keyword_box2d)
  (keyword_box3d)
] @type.builtin

; [
;   "::"
;   "<"
;   "<="
;   "<>"
;   "="
;   ">"
;   ">="
; ] @operator

; [
;   "("
;   ")"
;   "["
;   "]"
; ] @punctuation.bracket

[
 (constraint)
] @keyword

[
  (keyword_into)
  (keyword_values)
  (keyword_set)
  (keyword_from)
  (keyword_left)
  (keyword_right)
  (keyword_inner)
  (keyword_outer)
  (keyword_cross)
  (keyword_join)
  (keyword_lateral)
  (keyword_on)
  (keyword_where)
  (keyword_order_by)
  (keyword_group_by)
  (keyword_having)
  (keyword_desc)
  (keyword_asc)
  (keyword_limit)
  (keyword_offset)
  (keyword_primary)
  (keyword_add)
  (keyword_table)
  (keyword_view)
  (keyword_materialized)
  (keyword_column)
  (keyword_key)
  (keyword_as)
  (keyword_distinct)
  (keyword_constraint)
  ; (keyword_count)
  (keyword_max)
  (keyword_min)
  (keyword_avg)
  (keyword_case)
  (keyword_when)
  (keyword_then)
  (keyword_end)
  (keyword_in)
  (keyword_is)
  (keyword_force)
  (keyword_using)
  (keyword_use)
  (keyword_index)
  (keyword_exists)
  (keyword_auto_increment)
  (keyword_default)
  (keyword_cascade)
  (keyword_with)
  (keyword_no)
  (keyword_data)
  (keyword_type)
  (keyword_rename)
  (keyword_to)
  (keyword_schema)
  (keyword_owner)
  (keyword_temp)
  (keyword_temporary)
  (keyword_union)
  (keyword_all)
  (keyword_except)
  (keyword_intersect)
] @keyword

[
  (keyword_returning)
] @keyword.return

[
  (keyword_begin)
  (keyword_commit)
  (keyword_rollback)
  (keyword_transaction)
] @namespace

[
  (keyword_for)
] @repeat

[
  (keyword_if)
  (keyword_else)
] @conditional

[
  (keyword_and)
  (keyword_or)
  (keyword_not)
] @keyword.operator

[
  (keyword_select)
  (keyword_delete)
  (keyword_insert)
  (keyword_replace)
  (keyword_update)

  (keyword_create)
  (keyword_alter)
  (keyword_drop)
] @method

[
 (function_call name: (_) @function)
 (function_call (invocation name: (_) @function))
]
