export type Order = {
  id: string;
  status: 'pending' | 'paid' | 'failed';
  attempts: number;
  idempotencyKey?: string;
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

function retryDelayMs(attempt: number): number {
  const capped = Math.min(attempt, 5);
  return 200 * Math.pow(2, capped);
}

function ensureIdempotencyKey(order: Order): Order {
  if (order.idempotencyKey) {
    return order;
  }

  // Keep retries safe when payment provider receives duplicate submissions.
  return { ...order, idempotencyKey: `order-${order.id}` };
}

export async function retryCharge(
  order: Order,
  performCharge: (idempotencyKey: string) => Promise<void>
): Promise<Order> {
  let current = ensureIdempotencyKey(order);

  for (let attempt = 0; attempt < 6; attempt += 1) {
    try {
      await performCharge(current.idempotencyKey!);
      return markPaid({ ...current, attempts: attempt + 1 });
    } catch {
      await new Promise((resolve) => setTimeout(resolve, retryDelayMs(attempt)));
      current = { ...current, attempts: attempt + 1 };
    }
  }

  return markFailed(current);
}
