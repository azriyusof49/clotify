
document.addEventListener('DOMContentLoaded', function() {
    // Quantity controls
    const minusButtons = document.querySelectorAll('.minus');
    const plusButtons = document.querySelectorAll('.plus');
    const qtyInputs = document.querySelectorAll('.qty-input');
    
    // Handle minus button clicks
    minusButtons.forEach((btn, index) => {
        btn.addEventListener('click', function() {
            const input = qtyInputs[index];
            let value = parseInt(input.value);
            if (value > 1) {
                input.value = value - 1;
                updateSubtotal(index);
            }
        });
    });
    
    // Handle plus button clicks
    plusButtons.forEach((btn, index) => {
        btn.addEventListener('click', function() {
            const input = qtyInputs[index];
            let value = parseInt(input.value);
            input.value = value + 1;
            updateSubtotal(index);
        });
    });
    
    // Handle direct input changes
    qtyInputs.forEach((input, index) => {
        input.addEventListener('change', function() {
            if (parseInt(this.value) < 1) {
                this.value = 1;
            }
            updateSubtotal(index);
        });
    });
    
    // Remove item functionality
    const removeButtons = document.querySelectorAll('.remove-item');
    removeButtons.forEach((btn, index) => {
        btn.addEventListener('click', function() {
            const cartItem = this.closest('.cart-item');
            cartItem.remove();
            updateOrderSummary();
        });
    });
    
    // Update subtotal for individual items
    function updateSubtotal(index) {
        const cartItem = document.querySelectorAll('.cart-item')[index];
        const price = parseFloat(cartItem.querySelector('.item-price').textContent.replace('RM ', ''));
        const quantity = parseInt(cartItem.querySelector('.qty-input').value);
        const subtotal = price * quantity;
        
        cartItem.querySelector('.subtotal-amount').textContent = `RM ${subtotal.toFixed(2)}`;
        updateOrderSummary();
    }
    
    // Update order summary
    function updateOrderSummary() {
        const cartItems = document.querySelectorAll('.cart-item');
        let total = 0;
        let itemCount = 0;
        
        cartItems.forEach(item => {
            const price = parseFloat(item.querySelector('.item-price').textContent.replace('RM ', ''));
            const quantity = parseInt(item.querySelector('.qty-input').value);
            total += price * quantity;
            itemCount += quantity;
        });
        
        // Update summary displays
        const summaryLines = document.querySelectorAll('.summary-line span:last-child');
        summaryLines.forEach(span => {
            span.textContent = `RM ${total.toFixed(2)}`;
        });
        
        // Update item count
        const orderSummaryTitle = document.querySelector('.order-summary h2');
        orderSummaryTitle.textContent = `ORDER SUMMARY (${itemCount} ITEMS)`;
    }
    
    // Checkout button
    const checkoutBtn = document.querySelector('.checkout-btn');
    checkoutBtn.addEventListener('click', function() {
        alert('Proceeding to checkout...');
        // Add your checkout logic here
    });
    
    // Continue shopping button
    const continueBtn = document.querySelector('.continue-shopping-btn');
    continueBtn.addEventListener('click', function() {
        // Redirect to shopping page
        window.location.href = '/shop';
    });
});
