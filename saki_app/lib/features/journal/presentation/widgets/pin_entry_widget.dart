import 'package:flutter/material.dart';

class PinEntryWidget extends StatefulWidget {
  final ValueChanged<String> onComplete;
  final int pinLength;
  final String title;
  final String subtitle;
  final String? errorText;

  const PinEntryWidget({
    super.key,
    required this.onComplete,
    this.pinLength = 4,
    required this.title,
    this.subtitle = '',
    this.errorText,
  });

  @override
  State<PinEntryWidget> createState() => _PinEntryWidgetState();
}

class _PinEntryWidgetState extends State<PinEntryWidget> {
  String _pin = '';

  void _onKeyPressed(String key) {
    if (_pin.length < widget.pinLength) {
      setState(() {
        _pin += key;
      });
      if (_pin.length == widget.pinLength) {
        widget.onComplete(_pin);
        // Clear pin slightly after completion for potential re-entry (e.g. if error)
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              _pin = '';
            });
          }
        });
      }
    }
  }

  void _onDeletePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        if (widget.subtitle.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            widget.subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.pinLength, (index) {
            final isFilled = index < _pin.length;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFilled ? Theme.of(context).colorScheme.primary : Colors.transparent,
                border: Border.all(
                  color: isFilled ? Theme.of(context).colorScheme.primary : Colors.grey,
                  width: 2,
                ),
              ),
            );
          }),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            widget.errorText!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
        const SizedBox(height: 48),
        _buildKeypad(),
      ],
    );
  }

  Widget _buildKeypad() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Column(
        children: [
          _buildRow(['1', '2', '3']),
          const SizedBox(height: 16),
          _buildRow(['4', '5', '6']),
          const SizedBox(height: 16),
          _buildRow(['7', '8', '9']),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 64, height: 64), // Empty space
              _buildKey('0'),
              _buildDeleteKey(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((k) => _buildKey(k)).toList(),
    );
  }

  Widget _buildKey(String key) {
    return InkWell(
      onTap: () => _onKeyPressed(key),
      customBorder: const CircleBorder(),
      child: Container(
        width: 64,
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        ),
        child: Text(
          key,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildDeleteKey() {
    return InkWell(
      onTap: _onDeletePressed,
      customBorder: const CircleBorder(),
      child: const SizedBox(
        width: 64,
        height: 64,
        child: Icon(Icons.backspace_outlined),
      ),
    );
  }
}
