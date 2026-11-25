<*
 OpenXR 1.0, the part a Vulkan renderer drawing a stereo projection layer needs:
 instance, system, session, spaces, swapchains, the frame loop, views and events,
 actions for controller input and haptics, with XR_KHR_vulkan_enable and the two
 Android loader extensions, plus the optional XR_FB_display_refresh_rate,
 XR_EXT_performance_settings and XR_FB_passthrough.

 Layouts follow openxr.h field for field; test/xr_abi_test.c3 checks the sizes.
 Vulkan handles are `void*` so this library does not depend on a Vulkan binding.
*>
module xr;

import std::io;

alias Result = CInt;
alias StructureType = CInt;

typedef Instance = inline void*;
typedef Session = inline void*;
typedef Space = inline void*;
typedef Swapchain = inline void*;
typedef ActionSet = inline void*;
typedef Action = inline void*;
typedef PassthroughFB = inline void*;
typedef PassthroughLayerFB = inline void*;

alias SystemId = ulong;
alias Time = long;
alias Duration = long;
alias Version = ulong;
alias Flags64 = ulong;
alias Bool32 = uint;
// An interned string such as "/user/hand/left"; see `string_to_path`.
alias Path = ulong;

const Result SUCCESS            = 0;
const Result TIMEOUT_EXPIRED    = 1;
const Result SESSION_LOSS_PENDING = 3;
const Result EVENT_UNAVAILABLE  = 4;
const Result SESSION_NOT_FOCUSED = 8;
const Result FRAME_DISCARDED    = 9;
const Result ERROR_FORM_FACTOR_UNAVAILABLE = -35;
const Result ERROR_PATH_UNSUPPORTED = -22;
const Result ERROR_ACTIONSETS_ALREADY_ATTACHED = -47;

const StructureType TYPE_EXTENSION_PROPERTIES                 = 2;
const StructureType TYPE_INSTANCE_CREATE_INFO                 = 3;
const StructureType TYPE_SYSTEM_GET_INFO                      = 4;
const StructureType TYPE_VIEW_LOCATE_INFO                     = 6;
const StructureType TYPE_VIEW                                 = 7;
const StructureType TYPE_SESSION_CREATE_INFO                  = 8;
const StructureType TYPE_SWAPCHAIN_CREATE_INFO                = 9;
const StructureType TYPE_SESSION_BEGIN_INFO                   = 10;
const StructureType TYPE_VIEW_STATE                           = 11;
const StructureType TYPE_FRAME_END_INFO                       = 12;
const StructureType TYPE_EVENT_DATA_BUFFER                    = 16;
const StructureType TYPE_EVENT_DATA_INSTANCE_LOSS_PENDING     = 17;
const StructureType TYPE_EVENT_DATA_SESSION_STATE_CHANGED     = 18;
const StructureType TYPE_INSTANCE_PROPERTIES                  = 32;
const StructureType TYPE_FRAME_WAIT_INFO                      = 33;
const StructureType TYPE_COMPOSITION_LAYER_PROJECTION         = 35;
const StructureType TYPE_REFERENCE_SPACE_CREATE_INFO          = 37;
const StructureType TYPE_VIEW_CONFIGURATION_VIEW              = 41;
const StructureType TYPE_FRAME_STATE                          = 44;
const StructureType TYPE_FRAME_BEGIN_INFO                     = 46;
const StructureType TYPE_COMPOSITION_LAYER_PROJECTION_VIEW    = 48;
const StructureType TYPE_SWAPCHAIN_IMAGE_ACQUIRE_INFO         = 55;
const StructureType TYPE_SWAPCHAIN_IMAGE_WAIT_INFO            = 56;
const StructureType TYPE_SWAPCHAIN_IMAGE_RELEASE_INFO         = 57;
const StructureType TYPE_INSTANCE_CREATE_INFO_ANDROID_KHR     = 1000008000;
const StructureType TYPE_GRAPHICS_BINDING_VULKAN_KHR          = 1000025000;
const StructureType TYPE_SWAPCHAIN_IMAGE_VULKAN_KHR           = 1000025001;
const StructureType TYPE_GRAPHICS_REQUIREMENTS_VULKAN_KHR     = 1000025002;
const StructureType TYPE_LOADER_INIT_INFO_ANDROID_KHR         = 1000089000;
const StructureType TYPE_EVENT_DATA_DISPLAY_REFRESH_RATE_CHANGED_FB = 1000101000;
const StructureType TYPE_SYSTEM_PROPERTIES                    = 5;
const StructureType TYPE_HAPTIC_VIBRATION                     = 13;
const StructureType TYPE_ACTION_STATE_BOOLEAN                 = 23;
const StructureType TYPE_ACTION_STATE_FLOAT                   = 24;
const StructureType TYPE_ACTION_STATE_VECTOR2F                = 25;
const StructureType TYPE_ACTION_STATE_POSE                    = 27;
const StructureType TYPE_ACTION_SET_CREATE_INFO               = 28;
const StructureType TYPE_ACTION_CREATE_INFO                   = 29;
const StructureType TYPE_ACTION_SPACE_CREATE_INFO             = 38;
const StructureType TYPE_SPACE_LOCATION                       = 42;
const StructureType TYPE_SPACE_VELOCITY                       = 43;
const StructureType TYPE_INTERACTION_PROFILE_SUGGESTED_BINDING = 51;
const StructureType TYPE_EVENT_DATA_INTERACTION_PROFILE_CHANGED = 52;
const StructureType TYPE_INTERACTION_PROFILE_STATE            = 53;
const StructureType TYPE_ACTION_STATE_GET_INFO                = 58;
const StructureType TYPE_HAPTIC_ACTION_INFO                   = 59;
const StructureType TYPE_SESSION_ACTION_SETS_ATTACH_INFO      = 60;
const StructureType TYPE_ACTIONS_SYNC_INFO                    = 61;
const StructureType TYPE_PASSTHROUGH_CREATE_INFO_FB           = 1000118001;
const StructureType TYPE_PASSTHROUGH_LAYER_CREATE_INFO_FB     = 1000118002;
const StructureType TYPE_COMPOSITION_LAYER_PASSTHROUGH_FB     = 1000118003;
const StructureType TYPE_SYSTEM_PASSTHROUGH_PROPERTIES2_FB    = 1000118006;
const StructureType TYPE_EVENT_DATA_PASSTHROUGH_STATE_CHANGED_FB = 1000118030;
const StructureType TYPE_COMPOSITION_LAYER_SETTINGS_FB        = 1000204000;

const CInt FORM_FACTOR_HEAD_MOUNTED_DISPLAY       = 1;
const CInt VIEW_CONFIGURATION_TYPE_PRIMARY_STEREO = 2;
const CInt ENVIRONMENT_BLEND_MODE_OPAQUE          = 1;
const CInt ENVIRONMENT_BLEND_MODE_ADDITIVE        = 2;
const CInt ENVIRONMENT_BLEND_MODE_ALPHA_BLEND     = 3;

const CInt ACTION_TYPE_BOOLEAN_INPUT    = 1;
const CInt ACTION_TYPE_FLOAT_INPUT      = 2;
const CInt ACTION_TYPE_VECTOR2F_INPUT   = 3;
const CInt ACTION_TYPE_POSE_INPUT       = 4;
const CInt ACTION_TYPE_VIBRATION_OUTPUT = 100;

const CInt REFERENCE_SPACE_TYPE_VIEW        = 1;
const CInt REFERENCE_SPACE_TYPE_LOCAL       = 2;
const CInt REFERENCE_SPACE_TYPE_STAGE       = 3;
const CInt REFERENCE_SPACE_TYPE_LOCAL_FLOOR = 1000426000;

const CInt SESSION_STATE_IDLE         = 1;
const CInt SESSION_STATE_READY        = 2;
const CInt SESSION_STATE_SYNCHRONIZED = 3;
const CInt SESSION_STATE_VISIBLE      = 4;
const CInt SESSION_STATE_FOCUSED      = 5;
const CInt SESSION_STATE_STOPPING     = 6;
const CInt SESSION_STATE_LOSS_PENDING = 7;
const CInt SESSION_STATE_EXITING      = 8;

const Flags64 SWAPCHAIN_USAGE_COLOR_ATTACHMENT_BIT = 0x01;
const Flags64 SWAPCHAIN_USAGE_TRANSFER_DST_BIT     = 0x10;
const Flags64 SWAPCHAIN_USAGE_SAMPLED_BIT          = 0x20;

const Flags64 VIEW_STATE_ORIENTATION_VALID_BIT = 0x01;
const Flags64 VIEW_STATE_POSITION_VALID_BIT    = 0x02;

const Flags64 SPACE_LOCATION_ORIENTATION_VALID_BIT = 0x01;
const Flags64 SPACE_LOCATION_POSITION_VALID_BIT    = 0x02;

const Flags64 SPACE_VELOCITY_LINEAR_VALID_BIT  = 0x01;
const Flags64 SPACE_VELOCITY_ANGULAR_VALID_BIT = 0x02;

const Flags64 COMPOSITION_LAYER_BLEND_TEXTURE_SOURCE_ALPHA_BIT = 0x02;
const Flags64 COMPOSITION_LAYER_UNPREMULTIPLIED_ALPHA_BIT      = 0x04;

const Duration INFINITE_DURATION = 0x7fffffffffffffff;
// The shortest pulse the runtime can make.
const Duration MIN_HAPTIC_DURATION = -1;
const Path NULL_PATH = 0;

const usz MAX_APPLICATION_NAME_SIZE = 128;
const usz MAX_ENGINE_NAME_SIZE      = 128;
const usz MAX_RUNTIME_NAME_SIZE     = 128;
const usz MAX_RESULT_STRING_SIZE    = 64;
const usz MAX_EXTENSION_NAME_SIZE   = 128;
const usz MAX_ACTION_SET_NAME_SIZE  = 64;
const usz MAX_ACTION_NAME_SIZE      = 64;
const usz MAX_LOCALIZED_ACTION_SET_NAME_SIZE = 128;
const usz MAX_LOCALIZED_ACTION_NAME_SIZE     = 128;
const usz MAX_SYSTEM_NAME_SIZE      = 256;
const usz MAX_PATH_LENGTH           = 256;

const ZString FB_DISPLAY_REFRESH_RATE_EXTENSION_NAME = "XR_FB_display_refresh_rate";
const ZString EXT_PERFORMANCE_SETTINGS_EXTENSION_NAME = "XR_EXT_performance_settings";
const ZString FB_PASSTHROUGH_EXTENSION_NAME = "XR_FB_passthrough";
const ZString FB_COMPOSITION_LAYER_SETTINGS_EXTENSION_NAME = "XR_FB_composition_layer_settings";
const ZString META_AUTOMATIC_LAYER_FILTER_EXTENSION_NAME = "XR_META_automatic_layer_filter";

// XR_EXT_performance_settings: which processor a level is for, and the levels.
const CInt PERF_SETTINGS_DOMAIN_CPU = 1;
const CInt PERF_SETTINGS_DOMAIN_GPU = 2;
const CInt PERF_SETTINGS_LEVEL_POWER_SAVINGS  = 0;
const CInt PERF_SETTINGS_LEVEL_SUSTAINED_LOW  = 25;
const CInt PERF_SETTINGS_LEVEL_SUSTAINED_HIGH = 50;
const CInt PERF_SETTINGS_LEVEL_BOOST          = 75;

// XR_FB_passthrough: what the system can do, how a passthrough starts, and why
// one stopped.
const Flags64 PASSTHROUGH_CAPABILITY_BIT_FB             = 0x01;
const Flags64 PASSTHROUGH_CAPABILITY_COLOR_BIT_FB       = 0x02;
const Flags64 PASSTHROUGH_CAPABILITY_LAYER_DEPTH_BIT_FB = 0x04;
const Flags64 PASSTHROUGH_IS_RUNNING_AT_CREATION_BIT_FB = 0x01;
const CInt PASSTHROUGH_LAYER_PURPOSE_RECONSTRUCTION_FB  = 0;
const Flags64 PASSTHROUGH_STATE_CHANGED_REINIT_REQUIRED_BIT_FB        = 0x01;
const Flags64 PASSTHROUGH_STATE_CHANGED_NON_RECOVERABLE_ERROR_BIT_FB  = 0x02;
const Flags64 PASSTHROUGH_STATE_CHANGED_RECOVERABLE_ERROR_BIT_FB      = 0x04;
const Flags64 PASSTHROUGH_STATE_CHANGED_RESTORED_ERROR_BIT_FB         = 0x08;

<*
 XR_FB_composition_layer_settings: how the compositor filters a layer as it
 samples it. Quality sharpening is Meta Quest Super Resolution, an upscale and
 sharpen in one pass. AUTO_LAYER_FILTER (XR_META_automatic_layer_filter) lets
 the runtime drop the filter where it wouldn't help. All are suggestions.
*>
constset CompositionLayerSettingsFlagsFB : inline Flags64
{
	NORMAL_SUPER_SAMPLING  = 0x01,
	QUALITY_SUPER_SAMPLING = 0x02,
	NORMAL_SHARPENING      = 0x04,
	QUALITY_SHARPENING     = 0x08,
	AUTO_LAYER_FILTER      = 0x20,
}

struct Vector2f
{
	float x;
	float y;
}

struct Vector3f
{
	float x;
	float y;
	float z;
}

struct Quaternionf
{
	float x;
	float y;
	float z;
	float w;
}

struct Posef
{
	Quaternionf orientation;
	Vector3f position;
}

struct Fovf
{
	float angle_left;
	float angle_right;
	float angle_up;
	float angle_down;
}

struct Offset2Di
{
	int x;
	int y;
}

struct Extent2Di
{
	int width;
	int height;
}

struct Rect2Di
{
	Offset2Di offset;
	Extent2Di extent;
}

struct ApplicationInfo
{
	char[MAX_APPLICATION_NAME_SIZE] application_name;
	uint application_version;
	char[MAX_ENGINE_NAME_SIZE] engine_name;
	uint engine_version;
	Version api_version;
}

struct InstanceCreateInfo
{
	StructureType type;
	void* next;
	Flags64 create_flags;
	ApplicationInfo application_info;
	uint enabled_api_layer_count;
	ZString* enabled_api_layer_names;
	uint enabled_extension_count;
	ZString* enabled_extension_names;
}

struct InstanceCreateInfoAndroidKHR
{
	StructureType type;
	void* next;
	void* application_vm;
	void* application_activity;
}

struct LoaderInitInfoAndroidKHR
{
	StructureType type;
	void* next;
	void* application_vm;
	void* application_context;
}

struct EventDataDisplayRefreshRateChangedFB
{
	StructureType type;
	void* next;
	float from_display_refresh_rate;
	float to_display_refresh_rate;
}

struct ExtensionProperties
{
	StructureType type;
	void* next;
	char[MAX_EXTENSION_NAME_SIZE] extension_name;
	uint extension_version;
}

struct InstanceProperties
{
	StructureType type;
	void* next;
	Version runtime_version;
	char[MAX_RUNTIME_NAME_SIZE] runtime_name;
}

struct SystemGetInfo
{
	StructureType type;
	void* next;
	CInt form_factor;
}

struct ViewConfigurationView
{
	StructureType type;
	void* next;
	uint recommended_image_rect_width;
	uint max_image_rect_width;
	uint recommended_image_rect_height;
	uint max_image_rect_height;
	uint recommended_swapchain_sample_count;
	uint max_swapchain_sample_count;
}

struct GraphicsRequirementsVulkanKHR
{
	StructureType type;
	void* next;
	Version min_api_version_supported;
	Version max_api_version_supported;
}

struct GraphicsBindingVulkanKHR
{
	StructureType type;
	void* next;
	void* instance;
	void* physical_device;
	void* device;
	uint queue_family_index;
	uint queue_index;
}

struct SessionCreateInfo
{
	StructureType type;
	void* next;
	Flags64 create_flags;
	SystemId system_id;
}

struct SessionBeginInfo
{
	StructureType type;
	void* next;
	CInt primary_view_configuration_type;
}

struct ReferenceSpaceCreateInfo
{
	StructureType type;
	void* next;
	CInt reference_space_type;
	Posef pose_in_reference_space;
}

struct SwapchainCreateInfo
{
	StructureType type;
	void* next;
	Flags64 create_flags;
	Flags64 usage_flags;
	long format;
	uint sample_count;
	uint width;
	uint height;
	uint face_count;
	uint array_size;
	uint mip_count;
}

struct SwapchainImageVulkanKHR
{
	StructureType type;
	void* next;
	void* image;
}

struct SwapchainImageAcquireInfo
{
	StructureType type;
	void* next;
}

struct SwapchainImageWaitInfo
{
	StructureType type;
	void* next;
	Duration timeout;
}

struct SwapchainImageReleaseInfo
{
	StructureType type;
	void* next;
}

struct FrameWaitInfo
{
	StructureType type;
	void* next;
}

struct FrameState
{
	StructureType type;
	void* next;
	Time predicted_display_time;
	Duration predicted_display_period;
	Bool32 should_render;
}

struct FrameBeginInfo
{
	StructureType type;
	void* next;
}

struct CompositionLayerBaseHeader
{
	StructureType type;
	void* next;
	Flags64 layer_flags;
	Space space;
}

struct SwapchainSubImage
{
	Swapchain swapchain;
	Rect2Di image_rect;
	uint image_array_index;
}

struct CompositionLayerProjectionView
{
	StructureType type;
	void* next;
	Posef pose;
	Fovf fov;
	SwapchainSubImage sub_image;
}

struct CompositionLayerProjection
{
	StructureType type;
	void* next;
	Flags64 layer_flags;
	Space space;
	uint view_count;
	CompositionLayerProjectionView* views;
}

struct FrameEndInfo
{
	StructureType type;
	void* next;
	Time display_time;
	CInt environment_blend_mode;
	uint layer_count;
	CompositionLayerBaseHeader** layers;
}

struct ViewLocateInfo
{
	StructureType type;
	void* next;
	CInt view_configuration_type;
	Time display_time;
	Space space;
}

struct ViewState
{
	StructureType type;
	void* next;
	Flags64 view_state_flags;
}

struct View
{
	StructureType type;
	void* next;
	Posef pose;
	Fovf fov;
}

struct EventDataBuffer
{
	StructureType type;
	void* next;
	char[4000] varying;
}

struct EventDataSessionStateChanged
{
	StructureType type;
	void* next;
	Session session;
	CInt state;
	Time time;
}

struct SystemGraphicsProperties
{
	uint max_swapchain_image_height;
	uint max_swapchain_image_width;
	uint max_layer_count;
}

struct SystemTrackingProperties
{
	Bool32 orientation_tracking;
	Bool32 position_tracking;
}

struct SystemProperties
{
	StructureType type;
	void* next;
	SystemId system_id;
	uint vendor_id;
	char[MAX_SYSTEM_NAME_SIZE] system_name;
	SystemGraphicsProperties graphics_properties;
	SystemTrackingProperties tracking_properties;
}

struct ActionSetCreateInfo
{
	StructureType type;
	void* next;
	char[MAX_ACTION_SET_NAME_SIZE] action_set_name;
	char[MAX_LOCALIZED_ACTION_SET_NAME_SIZE] localized_action_set_name;
	uint priority;
}

struct ActionCreateInfo
{
	StructureType type;
	void* next;
	char[MAX_ACTION_NAME_SIZE] action_name;
	CInt action_type;
	uint count_subaction_paths;
	Path* subaction_paths;
	char[MAX_LOCALIZED_ACTION_NAME_SIZE] localized_action_name;
}

struct ActionSuggestedBinding
{
	Action action;
	Path binding;
}

struct InteractionProfileSuggestedBinding
{
	StructureType type;
	void* next;
	Path interaction_profile;
	uint count_suggested_bindings;
	ActionSuggestedBinding* suggested_bindings;
}

struct SessionActionSetsAttachInfo
{
	StructureType type;
	void* next;
	uint count_action_sets;
	ActionSet* action_sets;
}

struct ActiveActionSet
{
	ActionSet action_set;
	Path subaction_path;
}

struct ActionsSyncInfo
{
	StructureType type;
	void* next;
	uint count_active_action_sets;
	ActiveActionSet* active_action_sets;
}

struct ActionStateGetInfo
{
	StructureType type;
	void* next;
	Action action;
	Path subaction_path;
}

struct ActionStateBoolean
{
	StructureType type;
	void* next;
	Bool32 current_state;
	Bool32 changed_since_last_sync;
	Time last_change_time;
	Bool32 is_active;
}

struct ActionStateFloat
{
	StructureType type;
	void* next;
	float current_state;
	Bool32 changed_since_last_sync;
	Time last_change_time;
	Bool32 is_active;
}

struct ActionStateVector2f
{
	StructureType type;
	void* next;
	Vector2f current_state;
	Bool32 changed_since_last_sync;
	Time last_change_time;
	Bool32 is_active;
}

struct ActionStatePose
{
	StructureType type;
	void* next;
	Bool32 is_active;
}

struct ActionSpaceCreateInfo
{
	StructureType type;
	void* next;
	Action action;
	Path subaction_path;
	Posef pose_in_action_space;
}

struct SpaceLocation
{
	StructureType type;
	void* next;
	Flags64 location_flags;
	Posef pose;
}

// Chained on a `SpaceLocation`'s `next`: how fast the space moves, in the base space.
struct SpaceVelocity
{
	StructureType type;
	void* next;
	Flags64 velocity_flags;
	Vector3f linear_velocity;
	Vector3f angular_velocity;
}

struct HapticActionInfo
{
	StructureType type;
	void* next;
	Action action;
	Path subaction_path;
}

// What `apply_haptic_feedback` takes; `HapticVibration` is the one kind.
struct HapticBaseHeader
{
	StructureType type;
	void* next;
}

struct HapticVibration
{
	StructureType type;
	void* next;
	Duration duration;
	// 0 lets the runtime pick.
	float frequency;
	float amplitude;
}

struct InteractionProfileState
{
	StructureType type;
	void* next;
	Path interaction_profile;
}

struct EventDataInteractionProfileChanged
{
	StructureType type;
	void* next;
	Session session;
}

struct SystemPassthroughProperties2FB
{
	StructureType type;
	void* next;
	Flags64 capabilities;
}

struct PassthroughCreateInfoFB
{
	StructureType type;
	void* next;
	Flags64 flags;
}

struct PassthroughLayerCreateInfoFB
{
	StructureType type;
	void* next;
	PassthroughFB passthrough;
	Flags64 flags;
	CInt purpose;
}

// Chained on a layer's `next`.
struct CompositionLayerSettingsFB
{
	StructureType type;
	void* next;
	CompositionLayerSettingsFlagsFB layer_flags;
}

// Starts like `CompositionLayerBaseHeader`, so it goes in the same layer list.
struct CompositionLayerPassthroughFB
{
	StructureType type;
	void* next;
	Flags64 flags;
	Space space;
	PassthroughLayerFB layer_handle;
}

struct EventDataPassthroughStateChangedFB
{
	StructureType type;
	void* next;
	Flags64 flags;
}

alias VoidFn = fn void();

extern fn Result get_instance_proc_addr(Instance instance, ZString name, VoidFn* function) @cname("xrGetInstanceProcAddr");

alias InitializeLoaderFn = fn Result(LoaderInitInfoAndroidKHR* info);
alias CreateInstanceFn = fn Result(InstanceCreateInfo* info, Instance* instance);
alias EnumerateInstanceExtensionPropertiesFn = fn Result(ZString layer, uint capacity, uint* count, ExtensionProperties* properties);
alias EnumerateDisplayRefreshRatesFn = fn Result(Session session, uint capacity, uint* count, float* rates);
alias GetDisplayRefreshRateFn = fn Result(Session session, float* rate);
alias RequestDisplayRefreshRateFn = fn Result(Session session, float rate);
alias PerfSettingsSetPerformanceLevelFn = fn Result(Session session, CInt domain, CInt level);
alias DestroyInstanceFn = fn Result(Instance instance);
alias GetInstancePropertiesFn = fn Result(Instance instance, InstanceProperties* properties);
alias ResultToStringFn = fn Result(Instance instance, Result value, char* buffer);
alias GetSystemFn = fn Result(Instance instance, SystemGetInfo* info, SystemId* system);
alias EnumerateViewConfigurationViewsFn = fn Result(Instance instance, SystemId system, CInt type, uint capacity, uint* count, ViewConfigurationView* views);
alias GetVulkanExtensionsFn = fn Result(Instance instance, SystemId system, uint capacity, uint* count, char* buffer);
alias GetVulkanGraphicsDeviceFn = fn Result(Instance instance, SystemId system, void* vk_instance, void** vk_physical_device);
alias GetVulkanGraphicsRequirementsFn = fn Result(Instance instance, SystemId system, GraphicsRequirementsVulkanKHR* requirements);
alias PollEventFn = fn Result(Instance instance, EventDataBuffer* event);
alias CreateSessionFn = fn Result(Instance instance, SessionCreateInfo* info, Session* session);
alias DestroySessionFn = fn Result(Session session);
alias BeginSessionFn = fn Result(Session session, SessionBeginInfo* info);
alias EndSessionFn = fn Result(Session session);
alias RequestExitSessionFn = fn Result(Session session);
alias EnumerateReferenceSpacesFn = fn Result(Session session, uint capacity, uint* count, CInt* spaces);
alias CreateReferenceSpaceFn = fn Result(Session session, ReferenceSpaceCreateInfo* info, Space* space);
alias DestroySpaceFn = fn Result(Space space);
alias EnumerateSwapchainFormatsFn = fn Result(Session session, uint capacity, uint* count, long* formats);
alias CreateSwapchainFn = fn Result(Session session, SwapchainCreateInfo* info, Swapchain* swapchain);
alias DestroySwapchainFn = fn Result(Swapchain swapchain);
alias EnumerateSwapchainImagesFn = fn Result(Swapchain swapchain, uint capacity, uint* count, SwapchainImageVulkanKHR* images);
alias AcquireSwapchainImageFn = fn Result(Swapchain swapchain, SwapchainImageAcquireInfo* info, uint* index);
alias WaitSwapchainImageFn = fn Result(Swapchain swapchain, SwapchainImageWaitInfo* info);
alias ReleaseSwapchainImageFn = fn Result(Swapchain swapchain, SwapchainImageReleaseInfo* info);
alias WaitFrameFn = fn Result(Session session, FrameWaitInfo* info, FrameState* state);
alias BeginFrameFn = fn Result(Session session, FrameBeginInfo* info);
alias EndFrameFn = fn Result(Session session, FrameEndInfo* info);
alias LocateViewsFn = fn Result(Session session, ViewLocateInfo* info, ViewState* state, uint capacity, uint* count, View* views);
alias GetSystemPropertiesFn = fn Result(Instance instance, SystemId system, SystemProperties* properties);
alias EnumerateEnvironmentBlendModesFn = fn Result(Instance instance, SystemId system, CInt view_type, uint capacity, uint* count, CInt* modes);
alias StringToPathFn = fn Result(Instance instance, ZString text, Path* path);
alias PathToStringFn = fn Result(Instance instance, Path path, uint capacity, uint* count, char* buffer);
alias CreateActionSetFn = fn Result(Instance instance, ActionSetCreateInfo* info, ActionSet* set);
alias DestroyActionSetFn = fn Result(ActionSet set);
alias CreateActionFn = fn Result(ActionSet set, ActionCreateInfo* info, Action* action);
alias SuggestInteractionProfileBindingsFn = fn Result(Instance instance, InteractionProfileSuggestedBinding* bindings);
alias AttachSessionActionSetsFn = fn Result(Session session, SessionActionSetsAttachInfo* info);
alias GetCurrentInteractionProfileFn = fn Result(Session session, Path user_path, InteractionProfileState* state);
alias SyncActionsFn = fn Result(Session session, ActionsSyncInfo* info);
alias GetActionStateBooleanFn = fn Result(Session session, ActionStateGetInfo* info, ActionStateBoolean* state);
alias GetActionStateFloatFn = fn Result(Session session, ActionStateGetInfo* info, ActionStateFloat* state);
alias GetActionStateVector2fFn = fn Result(Session session, ActionStateGetInfo* info, ActionStateVector2f* state);
alias GetActionStatePoseFn = fn Result(Session session, ActionStateGetInfo* info, ActionStatePose* state);
alias CreateActionSpaceFn = fn Result(Session session, ActionSpaceCreateInfo* info, Space* space);
alias LocateSpaceFn = fn Result(Space space, Space base, Time time, SpaceLocation* location);
alias ApplyHapticFeedbackFn = fn Result(Session session, HapticActionInfo* info, HapticBaseHeader* feedback);
alias StopHapticFeedbackFn = fn Result(Session session, HapticActionInfo* info);
alias CreatePassthroughFn = fn Result(Session session, PassthroughCreateInfoFB* info, PassthroughFB* passthrough);
alias DestroyPassthroughFn = fn Result(PassthroughFB passthrough);
alias PassthroughControlFn = fn Result(PassthroughFB passthrough);
alias CreatePassthroughLayerFn = fn Result(Session session, PassthroughLayerCreateInfoFB* info, PassthroughLayerFB* layer);
alias PassthroughLayerControlFn = fn Result(PassthroughLayerFB layer);

<*
 Every command past xrGetInstanceProcAddr. `load_global` fills the three that
 need no instance, `load_instance` the rest.
*>
struct Commands
{
	InitializeLoaderFn initialize_loader;
	CreateInstanceFn create_instance;
	EnumerateInstanceExtensionPropertiesFn enumerate_instance_extension_properties;
	DestroyInstanceFn destroy_instance;
	GetInstancePropertiesFn get_instance_properties;
	ResultToStringFn result_to_string;
	GetSystemFn get_system;
	EnumerateViewConfigurationViewsFn enumerate_view_configuration_views;
	GetVulkanExtensionsFn get_vulkan_instance_extensions;
	GetVulkanExtensionsFn get_vulkan_device_extensions;
	GetVulkanGraphicsDeviceFn get_vulkan_graphics_device;
	GetVulkanGraphicsRequirementsFn get_vulkan_graphics_requirements;
	PollEventFn poll_event;
	CreateSessionFn create_session;
	DestroySessionFn destroy_session;
	BeginSessionFn begin_session;
	EndSessionFn end_session;
	RequestExitSessionFn request_exit_session;
	EnumerateReferenceSpacesFn enumerate_reference_spaces;
	CreateReferenceSpaceFn create_reference_space;
	DestroySpaceFn destroy_space;
	EnumerateSwapchainFormatsFn enumerate_swapchain_formats;
	CreateSwapchainFn create_swapchain;
	DestroySwapchainFn destroy_swapchain;
	EnumerateSwapchainImagesFn enumerate_swapchain_images;
	AcquireSwapchainImageFn acquire_swapchain_image;
	WaitSwapchainImageFn wait_swapchain_image;
	ReleaseSwapchainImageFn release_swapchain_image;
	WaitFrameFn wait_frame;
	BeginFrameFn begin_frame;
	EndFrameFn end_frame;
	LocateViewsFn locate_views;
	GetSystemPropertiesFn get_system_properties;
	EnumerateEnvironmentBlendModesFn enumerate_environment_blend_modes;
	StringToPathFn string_to_path;
	PathToStringFn path_to_string;
	CreateActionSetFn create_action_set;
	DestroyActionSetFn destroy_action_set;
	CreateActionFn create_action;
	SuggestInteractionProfileBindingsFn suggest_interaction_profile_bindings;
	AttachSessionActionSetsFn attach_session_action_sets;
	GetCurrentInteractionProfileFn get_current_interaction_profile;
	SyncActionsFn sync_actions;
	GetActionStateBooleanFn get_action_state_boolean;
	GetActionStateFloatFn get_action_state_float;
	GetActionStateVector2fFn get_action_state_vector2f;
	GetActionStatePoseFn get_action_state_pose;
	CreateActionSpaceFn create_action_space;
	LocateSpaceFn locate_space;
	ApplyHapticFeedbackFn apply_haptic_feedback;
	StopHapticFeedbackFn stop_haptic_feedback;
	// Null unless the instance enabled their extension - see `load_extensions`.
	EnumerateDisplayRefreshRatesFn enumerate_display_refresh_rates;
	GetDisplayRefreshRateFn get_display_refresh_rate;
	RequestDisplayRefreshRateFn request_display_refresh_rate;
	PerfSettingsSetPerformanceLevelFn perf_settings_set_performance_level;
	CreatePassthroughFn create_passthrough_fb;
	DestroyPassthroughFn destroy_passthrough_fb;
	PassthroughControlFn passthrough_start_fb;
	PassthroughControlFn passthrough_pause_fb;
	CreatePassthroughLayerFn create_passthrough_layer_fb;
	PassthroughLayerControlFn destroy_passthrough_layer_fb;
	PassthroughLayerControlFn passthrough_layer_pause_fb;
	PassthroughLayerControlFn passthrough_layer_resume_fb;
}

Commands cmd;

excuse COMMAND_MISSING, CALL_FAILED;

macro void? @load(Instance instance, #slot, ZString name) @private
{
	VoidFn found;
	Result r = get_instance_proc_addr(instance, name, &found);
	if (r < 0 || found == null)
	{
		io::eprintfn("xr: %s is not available (%d)", name, (int)r);
		return COMMAND_MISSING~;
	}
	#slot = ($Typeof(#slot))found;
}

<*
 Loads the commands callable before an instance exists.
 `xrInitializeLoaderKHR` is only required on Android, so it may stay null elsewhere.

 @return? COMMAND_MISSING
*>
fn void? load_global()
{
	@load((Instance)null, cmd.create_instance, "xrCreateInstance")!;
	@load((Instance)null, cmd.enumerate_instance_extension_properties, "xrEnumerateInstanceExtensionProperties")!;
	(void)@load((Instance)null, cmd.initialize_loader, "xrInitializeLoaderKHR");
}

<*
 Loads the optional extensions' commands. One the instance did not enable stays
 null, which is how a caller tells whether it has it.

 @require instance != null : "Instance must exist"
*>
fn void load_extensions(Instance instance, bool refresh_rate, bool performance, bool passthrough = false)
{
	if (refresh_rate)
	{
		(void)@load(instance, cmd.enumerate_display_refresh_rates, "xrEnumerateDisplayRefreshRatesFB");
		(void)@load(instance, cmd.get_display_refresh_rate, "xrGetDisplayRefreshRateFB");
		(void)@load(instance, cmd.request_display_refresh_rate, "xrRequestDisplayRefreshRateFB");
	}
	if (performance)
	{
		(void)@load(instance, cmd.perf_settings_set_performance_level, "xrPerfSettingsSetPerformanceLevelEXT");
	}
	if (passthrough)
	{
		(void)@load(instance, cmd.create_passthrough_fb, "xrCreatePassthroughFB");
		(void)@load(instance, cmd.destroy_passthrough_fb, "xrDestroyPassthroughFB");
		(void)@load(instance, cmd.passthrough_start_fb, "xrPassthroughStartFB");
		(void)@load(instance, cmd.passthrough_pause_fb, "xrPassthroughPauseFB");
		(void)@load(instance, cmd.create_passthrough_layer_fb, "xrCreatePassthroughLayerFB");
		(void)@load(instance, cmd.destroy_passthrough_layer_fb, "xrDestroyPassthroughLayerFB");
		(void)@load(instance, cmd.passthrough_layer_pause_fb, "xrPassthroughLayerPauseFB");
		(void)@load(instance, cmd.passthrough_layer_resume_fb, "xrPassthroughLayerResumeFB");
	}
}

<*
 Whether the runtime offers an instance extension, by name.

 @return? CALL_FAILED
*>
fn bool? has_extension(ZString name) => @pool()
{
	uint count;
	check(cmd.enumerate_instance_extension_properties(null, 0, &count, null), "xrEnumerateInstanceExtensionProperties")!;
	ExtensionProperties[] all = alloc::new_array(tmem, ExtensionProperties, count);
	foreach (&each : all) each.type = TYPE_EXTENSION_PROPERTIES;
	check(cmd.enumerate_instance_extension_properties(null, count, &count, all.ptr), "xrEnumerateInstanceExtensionProperties")!;
	foreach (&each : all[:count])
	{
		if (((ZString)&each.extension_name).str_view() == name.str_view()) return true;
	}
	return false;
}

<*
 Loads every instance-level command, including the XR_KHR_vulkan_enable ones.

 @require instance != null : "Instance must exist"
 @return? COMMAND_MISSING
*>
fn void? load_instance(Instance instance)
{
	@load(instance, cmd.destroy_instance, "xrDestroyInstance")!;
	@load(instance, cmd.get_instance_properties, "xrGetInstanceProperties")!;
	@load(instance, cmd.result_to_string, "xrResultToString")!;
	@load(instance, cmd.get_system, "xrGetSystem")!;
	@load(instance, cmd.enumerate_view_configuration_views, "xrEnumerateViewConfigurationViews")!;
	@load(instance, cmd.get_vulkan_instance_extensions, "xrGetVulkanInstanceExtensionsKHR")!;
	@load(instance, cmd.get_vulkan_device_extensions, "xrGetVulkanDeviceExtensionsKHR")!;
	@load(instance, cmd.get_vulkan_graphics_device, "xrGetVulkanGraphicsDeviceKHR")!;
	@load(instance, cmd.get_vulkan_graphics_requirements, "xrGetVulkanGraphicsRequirementsKHR")!;
	@load(instance, cmd.poll_event, "xrPollEvent")!;
	@load(instance, cmd.create_session, "xrCreateSession")!;
	@load(instance, cmd.destroy_session, "xrDestroySession")!;
	@load(instance, cmd.begin_session, "xrBeginSession")!;
	@load(instance, cmd.end_session, "xrEndSession")!;
	@load(instance, cmd.request_exit_session, "xrRequestExitSession")!;
	@load(instance, cmd.enumerate_reference_spaces, "xrEnumerateReferenceSpaces")!;
	@load(instance, cmd.create_reference_space, "xrCreateReferenceSpace")!;
	@load(instance, cmd.destroy_space, "xrDestroySpace")!;
	@load(instance, cmd.enumerate_swapchain_formats, "xrEnumerateSwapchainFormats")!;
	@load(instance, cmd.create_swapchain, "xrCreateSwapchain")!;
	@load(instance, cmd.destroy_swapchain, "xrDestroySwapchain")!;
	@load(instance, cmd.enumerate_swapchain_images, "xrEnumerateSwapchainImages")!;
	@load(instance, cmd.acquire_swapchain_image, "xrAcquireSwapchainImage")!;
	@load(instance, cmd.wait_swapchain_image, "xrWaitSwapchainImage")!;
	@load(instance, cmd.release_swapchain_image, "xrReleaseSwapchainImage")!;
	@load(instance, cmd.wait_frame, "xrWaitFrame")!;
	@load(instance, cmd.begin_frame, "xrBeginFrame")!;
	@load(instance, cmd.end_frame, "xrEndFrame")!;
	@load(instance, cmd.locate_views, "xrLocateViews")!;
	@load(instance, cmd.get_system_properties, "xrGetSystemProperties")!;
	@load(instance, cmd.enumerate_environment_blend_modes, "xrEnumerateEnvironmentBlendModes")!;
	@load(instance, cmd.string_to_path, "xrStringToPath")!;
	@load(instance, cmd.path_to_string, "xrPathToString")!;
	@load(instance, cmd.create_action_set, "xrCreateActionSet")!;
	@load(instance, cmd.destroy_action_set, "xrDestroyActionSet")!;
	@load(instance, cmd.create_action, "xrCreateAction")!;
	@load(instance, cmd.suggest_interaction_profile_bindings, "xrSuggestInteractionProfileBindings")!;
	@load(instance, cmd.attach_session_action_sets, "xrAttachSessionActionSets")!;
	@load(instance, cmd.get_current_interaction_profile, "xrGetCurrentInteractionProfile")!;
	@load(instance, cmd.sync_actions, "xrSyncActions")!;
	@load(instance, cmd.get_action_state_boolean, "xrGetActionStateBoolean")!;
	@load(instance, cmd.get_action_state_float, "xrGetActionStateFloat")!;
	@load(instance, cmd.get_action_state_vector2f, "xrGetActionStateVector2f")!;
	@load(instance, cmd.get_action_state_pose, "xrGetActionStatePose")!;
	@load(instance, cmd.create_action_space, "xrCreateActionSpace")!;
	@load(instance, cmd.locate_space, "xrLocateSpace")!;
	@load(instance, cmd.apply_haptic_feedback, "xrApplyHapticFeedback")!;
	@load(instance, cmd.stop_haptic_feedback, "xrStopHapticFeedback")!;
}

// The instance `check` names results through, once there is one.
Instance named_by @private;

fn void set_result_names(Instance instance) => named_by = instance;

<*
 Turns a failed result into CALL_FAILED, saying which call and why.
 Success codes (zero and above) pass.

 @return? CALL_FAILED
*>
fn void? check(Result r, String what)
{
	if (r >= 0) return;
	char[MAX_RESULT_STRING_SIZE] name;
	if (named_by != null && cmd.result_to_string != null && cmd.result_to_string(named_by, r, &name) >= 0)
	{
		io::eprintfn("xr: %s failed: %s", what, ((ZString)&name).str_view());
	}
	else
	{
		io::eprintfn("xr: %s failed: %d", what, (int)r);
	}
	return CALL_FAILED~;
}

macro Version make_version(ulong major, ulong minor, ulong patch) => (major << 48) | (minor << 32) | patch;
macro ulong version_major(Version v) => v >> 48;
macro ulong version_minor(Version v) => (v >> 32) & 0xffff;
