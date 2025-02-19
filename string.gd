extends RigidBody3D

@export resolution: int
@export rope_length: float
@export start_point: Node3D
end_point:Node3D

var segments[]

func _add_joints():
	var first_segment: RopeSegment = segments[0] # this is setting the first anchor point in segments
	var last_segment: RopeSegment = segments[resolution - 1] # this is the last anchor point
	var first_joint = _generate_joint_between(head_anchor, first_segment) # Appending segments to the list
	var last_joint = _generate_joint_between(last_segment, tail_anchor, 0)
	
	first_segment.add_child(first_joint)
	first_joint.global_transform.origin = start_point.global_transform.origin
	last_segment.add_child(last_joint)
	last_joint.global_transform.origin = end_point.global_transform.origin
	
	for i in len(segments):
		if segments.size() >= i + 2:
			var segment: RopeSegment = segments[i]
			var next_segment: RopeSegment = segments[i + 1]
			var joint = _generate_joint_between(segment, next_segment)
			segment.add_child(joint)
			var sphere_middle_point = segment.global_transform.origin + (next_segment.global_transform.origin - segment.global_transform.origin) * 0.5
			joint.global_transform.origin = sphere_middle_point


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
