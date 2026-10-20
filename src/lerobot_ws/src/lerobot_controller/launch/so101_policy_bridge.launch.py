from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node
from launch_ros.parameter_descriptions import ParameterValue


def generate_launch_description():
    input_topic = LaunchConfiguration("input_topic")
    arm_output_topic = LaunchConfiguration("arm_output_topic")
    gripper_output_topic = LaunchConfiguration("gripper_output_topic")
    time_from_start_sec = LaunchConfiguration("time_from_start_sec")

    return LaunchDescription(
        [
            DeclareLaunchArgument(
                "input_topic",
                default_value="/so101/policy_joint_command",
                description="JointState target topic published by the policy runner.",
            ),
            DeclareLaunchArgument(
                "arm_output_topic",
                default_value="/follower/arm_controller/joint_trajectory",
                description="JointTrajectory command topic for the arm controller.",
            ),
            DeclareLaunchArgument(
                "gripper_output_topic",
                default_value="/follower/gripper_controller/joint_trajectory",
                description="JointTrajectory command topic for the gripper controller.",
            ),
            DeclareLaunchArgument(
                "time_from_start_sec",
                default_value="0.1",
                description="Trajectory duration assigned to each converted command.",
            ),
            Node(
                package="lerobot_controller",
                executable="joint_state_to_trajectory",
                name="so101_policy_bridge",
                output="screen",
                parameters=[
                    {
                        "input_topic": input_topic,
                        "arm_output_topic": arm_output_topic,
                        "gripper_output_topic": gripper_output_topic,
                        "arm_joints": [
                            "Rotation",
                            "Pitch",
                            "Elbow",
                            "Wrist_Pitch",
                            "Wrist_Roll",
                        ],
                        "gripper_joints": ["Jaw"],
                        "time_from_start_sec": ParameterValue(
                            time_from_start_sec,
                            value_type=float,
                        ),
                    }
                ],
            ),
        ]
    )
