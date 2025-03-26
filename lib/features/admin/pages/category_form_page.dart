import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/common/utils/toast_msg.dart';
import 'package:flutter_ecommerce/common/widgets/app_loading.dart';
import 'package:flutter_ecommerce/common/widgets/custom_image_picker.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/category/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CategoryFormPage extends StatefulWidget {
  const CategoryFormPage({super.key});

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? _imageErrorMsg;
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
          child: FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'categoryName',
                    decoration: InputDecoration(
                        labelText: 'Category Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(3),
                      ],
                    ),
                  ),
                  Gap(16),
                  CustomImagePicker(
                      errorMessage: _imageErrorMsg,
                      onImagePicked: (file) {
                        if (file != null) {
                          setState(() {
                            _imageFile = file;
                            _imageErrorMsg = null;
                          });
                        } else {
                          setState(() {
                            _imageFile = null;
                            _imageErrorMsg = 'Please select an image';
                          });
                        }
                      }),
                  Gap(24),
                  _buildCategorySaveBtn(),
                ],
              )),
        ),
      ),
    );
  }

  BlocConsumer<CategoryBloc, CategoryState> _buildCategorySaveBtn() {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        state.whenOrNull(loaded: (data) {
          AppToast.success(context, data);
          context.pop();
        }, failure: (failure) {
          AppToast.error(context, failure.toString());
        });
      },
      builder: (context, state) {
        return state.maybeWhen(
            loading: () => Center(child: AppLoading.center()),
            orElse: () => SizedBox(
                  width: double.maxFinite,
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      return FilledButton(
                        onPressed: _onSubmitCategory,
                        child: const Text('Save'),
                      );
                    },
                  ),
                ));
      },
    );
  }

  void _onSubmitCategory() {
    setState(() {
      if (_imageFile == null) {
        return;
      }
    });
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final categoryName = _formKey.currentState!.value['categoryName'];
      sl<CategoryBloc>()
          .add(CategoryEvent.add(name: categoryName, imageFile: _imageFile!));
    }
  }
}
