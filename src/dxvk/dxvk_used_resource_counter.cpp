#include "dxvk_used_resource_counter.h"

#include "dxvk_buffer.h"
#include "dxvk_device.h"
#include "dxvk_image.h"

namespace dxvk {


void UsedResourceWatcher::markImageView(const Rc<DxvkImageView> &image_view) const {
  image_view->image()->m_image.usedFrameId = m_device->getCurrentFrameId();
}

void UsedResourceWatcher::markBufferView(const Rc<DxvkBufferView>& buffer_view) const{
  buffer_view->buffer()->m_buffer.usedFrameId = m_device->getCurrentFrameId();
}

} // namespace dxvk
