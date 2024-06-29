import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traccar_app/state/map_state.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final state = MapState.of(context);

    return GestureDetector(
      onTap: () async {
        final value = await DateRangePickerDialog.show(
          context,
          from: state.params.from,
          to: state.params.to,
        );

        if (value != null) {
          state.params.dateRange = value;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: ListenableBuilder(
          listenable: state.params,
          builder: (_, __) => Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              Text(
                state.params.fromText,
                style: const TextStyle(fontSize: 17),
              ),
              const Icon(Icons.arrow_forward, size: 18),
              Text(
                state.params.toText,
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateRangePickerDialog extends StatelessWidget {
  final DateRange dateRange;

  const DateRangePickerDialog({
    super.key,
    required this.dateRange,
  });

  static Future<DateRange?> show(
    BuildContext context, {
    required DateTime from,
    required DateTime to,
  }) {
    return showDialog<DateRange>(
      context: context,
      builder: (_) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: DateRangePickerDialog(
              dateRange: (from: from, to: to),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime from = dateRange.from;
    DateTime to = dateRange.to;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InputDateTime(
          label: 'Start',
          initialValue: from,
          onChanged: (value) => from = value,
        ),
        const SizedBox(height: 20),
        InputDateTime(
          label: 'End',
          initialValue: to,
          onChanged: (value) => to = value,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop((from: from, to: to));
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}

class InputDateTime extends StatefulWidget {
  final String label;
  final DateTime initialValue;
  final Function(DateTime) onChanged;

  const InputDateTime({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<InputDateTime> createState() => _InputDateTimeState();
}

class _InputDateTimeState extends State<InputDateTime> {
  late DateTime value;

  @override
  void initState() {
    super.initState();

    value = widget.initialValue;
  }

  void datePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: value,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      value = value.copyWith(
        year: date.year,
        month: date.month,
        day: date.day,
      );

      widget.onChanged(value);
      setState(() {});
    }
  }

  void timePicker() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(value),
    );

    if (time != null) {
      value = value.copyWith(
        hour: time.hour,
        minute: time.minute,
      );

      widget.onChanged(value);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: TextFormField(
                key: ValueKey(value),
                readOnly: true,
                onTap: datePicker,
                initialValue:
                    DateFormat("d MMMM yyyy").format(value).toLowerCase(),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: TextFormField(
                key: ValueKey(value),
                readOnly: true,
                onTap: timePicker,
                initialValue: DateFormat("h:mm a").format(value).toLowerCase(),
              ),
            ),
          ],
        )
      ],
    );
  }
}
