import 'package:flutter/material.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';

class ThemePreviewScreen extends StatefulWidget {
  @override
  State<ThemePreviewScreen> createState() => _ThemePreviewScreenState();
}

class _ThemePreviewScreenState extends State<ThemePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PromptAppBar(),
      drawer: PromptDrawer(),
      body: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: ListView(
          children: <Widget>[
            Text(
              'Font Preview',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 8),
            Text(
              'The quick brown fox jumps over the lazy dog',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16),
            Text(
              'Button Preview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Elevated Button'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('Outlined Button'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Text Button'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Checkbox Preview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Checkbox(
                  value: true,
                  onChanged: (_) {},
                ),
                Checkbox(
                  value: false,
                  onChanged: (_) {},
                ),
                Checkbox(
                  value: true,
                  onChanged: (_) {},
                  activeColor: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Radio Button Preview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Radio(
                      value: 'A',
                      groupValue: 'A',
                      onChanged: (_) {},
                    ),
                    Radio(
                      value: 'B',
                      groupValue: 'A',
                      onChanged: (_) {},
                    ),
                    Radio(
                      value: 'C',
                      groupValue: 'A',
                      onChanged: (_) {},
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Switch Preview',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Switch(
                  value: true,
                  onChanged: (_) {},
                ),
                Switch(
                  value: false,
                  onChanged: (_) {},
                ),
                Switch(
                  value: true,
                  onChanged: (_) {},
                  activeColor: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Text Field Preview',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter text here',
                labelText: 'Label',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Slider Preview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Slider(
              value: 0.5,
              onChanged: (_) {},
            ),
            SizedBox(height: 16),

            // SizedBox(height: 8),
            // Wrap(
            //   spacing: 8,
            //   children: <Widget>[
            //     ColorBox(color: Colors.red),
            //     ColorBox(color: Colors.orange),
            //     ColorBox(color: Colors.yellow),
            //     ColorBox(color: Colors.green),
            //     ColorBox(color: Colors.blue),
            //     ColorBox(color: Colors.purple),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class ColorBox extends StatelessWidget {
  final Color color;

  const ColorBox({required this.color}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(2, 2),
          ),
        ],
      ),
    );
  }
}
