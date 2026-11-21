<*
 OpenXR 1.0, the part a Vulkan renderer drawing a stereo projection layer needs:
 instance, system, session, spaces, swapchains, the frame loop, views and events,
 with XR_KHR_vulkan_enable and the two Android loader extensions.

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

alias SystemId = ulong;
alias Time = long;
alias Duration = long;
alias Version = ulong;
alias Flags64 = ulong;
alias Bool32 = uint;

const Result SUCCESS            = 0;
const Result TIMEOUT_EXPIRED    = 1;
const Result SESSION_LOSS_PENDING = 3;
const Result EVENT_UNAVAILABLE  = 4;
const Result SESSION_NOT_FOCUSED = 8;
const Result FRAME_DISCARDED    = 9;
const Result ERROR_FORM_FACTOR_UNAVAILABLE = -35;

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

const CInt FORM_FACTOR_HEAD_MOUNTED_DISPLAY       = 1;
const CInt VIEW_CONFIGURATION_TYPE_PRIMARY_STEREO = 2;
const CInt ENVIRONMENT_BLEND_MODE_OPAQUE          = 1;

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

const Duration INFINITE_DURATION = 0x7fffffffffffffff;

const usz MAX_APPLICATION_NAME_SIZE = 128;
const usz MAX_ENGINE_NAME_SIZE      = 128;
const usz MAX_RUNTIME_NAME_SIZE     = 128;
const usz MAX_RESULT_STRING_SIZE    = 64;

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

alias VoidFn = fn void();

extern fn Result get_instance_proc_addr(Instance instance, ZString name, VoidFn* function) @cname("xrGetInstanceProcAddr");

alias InitializeLoaderFn = fn Result(LoaderInitInfoAndroidKHR* info);
alias CreateInstanceFn = fn Result(InstanceCreateInfo* info, Instance* instance);
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

<*
 Every command past xrGetInstanceProcAddr. `load_global` fills the three that
 need no instance, `load_instance` the rest.
*>
struct Commands
{
	InitializeLoaderFn initialize_loader;
	CreateInstanceFn create_instance;
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
	(void)@load((Instance)null, cmd.initialize_loader, "xrInitializeLoaderKHR");
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
