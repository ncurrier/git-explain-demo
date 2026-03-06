export type Order = {
  id: string;
  status: 'pending' | 'paid' | 'failed';
  attempts: number;
};

export function initializeOrder(id: string): Order {
  return { id, status: 'pending', attempts: 0 };
}

export function markPaid(order: Order): Order {
  return { ...order, status: 'paid' };
}

export function markFailed(order: Order): Order {
  return { ...order, status: 'failed' };
}
