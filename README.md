# openxr.c3

[OpenXR](https://www.khronos.org/openxr/) bindings for C3: the part a Vulkan renderer needs to
draw a stereo projection layer on a headset. Written by hand against `openxr.h` (1.1.65), and
used by [three.c3](https://github.com/tonis2/three.c3) to run on Meta Quest 3.

## What is covered

- **Core 1.0:** instance, system, view configurations, session and its state events, reference
  spaces, swapchains, `xrWaitFrame` / `xrBeginFrame` / `xrEndFrame`, `xrLocateViews`, and
  projection layers.
- **`XR_KHR_vulkan_enable`:** the instance and device extensions the runtime wants, its physical
  device, its version range, and the Vulkan swapchain images.
- **`XR_KHR_loader_init_android`** and **`XR_KHR_android_create_instance`**.

Actions and input are not covered yet.

Vulkan handles are `void*`, so the library doesn't depend on any particular Vulkan binding.

## Using it

Add the directory to `dependency-search-paths` and `"openxr"` to `dependencies`. Link the loader
yourself (`-lopenxr_loader`). On Android it comes from the Khronos
[`openxr_loader_for_android`](https://central.sonatype.com/artifact/org.khronos.openxr/openxr_loader_for_android)
AAR, under `jni/arm64-v8a/`.

Only `xrGetInstanceProcAddr` is linked; every other command is loaded through it into
`xr::cmd`:

```c3
import xr;

xr::load_global()!;                    // xrCreateInstance, xrInitializeLoaderKHR
// Android: xr::cmd.initialize_loader(&loader_info) with the JavaVM and activity, first.

xr::Instance instance;
xr::check(xr::cmd.create_instance(&create_info, &instance), "xrCreateInstance")!;
xr::load_instance(instance)!;          // everything else
xr::set_result_names(instance);        // so `check` prints XR_ERROR_... names

xr::SystemGetInfo system_info = {
	.type = xr::TYPE_SYSTEM_GET_INFO,
	.form_factor = xr::FORM_FACTOR_HEAD_MOUNTED_DISPLAY,
};
xr::SystemId system;
xr::check(xr::cmd.get_system(instance, &system_info, &system), "xrGetSystem")!;
```

`xr::check` turns a failed `XrResult` into `xr::CALL_FAILED`, and prints which call failed and
why.

Struct and field names follow the C ones in snake_case (`XrFrameState.shouldRender` is
`xr::FrameState.should_render`). Constants drop the `XR_` prefix (`xr::TYPE_FRAME_STATE`,
`xr::SESSION_STATE_READY`).

A complete session (instance, Vulkan device hand-off, swapchain and frame loop) is in three.c3's
[`src/xr/`](https://github.com/tonis2/three.c3/tree/main/src/xr).

## Checking the layouts

The runtime reads these structs through raw pointers, so a field one slot off doesn't fail to
compile; it fails at runtime with an error that names nothing. three.c3's `test/xr_abi_test.c3`
compares every struct's size and key offsets against a C program built on the official headers.
Extend that test whenever you add a struct.

MIT licensed.
