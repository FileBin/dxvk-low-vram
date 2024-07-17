#pragma once

#include <atomic>
#include <cstddef>

#include "dxvk_include.h"


namespace dxvk {
  class DxvkDevice;
  class DxvkImage;
  class DxvkImageView;
  class DxvkBuffer;
  class DxvkBufferView;

template <typename T> struct ResourceCounter {
  std::list<Rc<T>> used;
  std::list<Rc<T>> not_used;
  std::atomic<size_t> mem_counter;
};

class UsedResourceWatcher {
public:

  void update();

  void markImageView(const Rc<DxvkImageView>& image_view) const;
  void markBufferView(const Rc<DxvkBufferView>& buffer_view) const;

private:
  Rc<DxvkDevice> m_device;

  ResourceCounter<DxvkImage> m_images;
  ResourceCounter<DxvkBuffer> m_buffers;
};

} // namespace dxvk