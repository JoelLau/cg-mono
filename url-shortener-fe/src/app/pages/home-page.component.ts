import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import {
  FormControl,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { ShortUrlApiService } from '../services/short-url-api/short-url-api.service';
import { StackLayoutComponent } from '../layouts/stack-layout.component';

@Component({
  selector: 'app-home-page',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    StackLayoutComponent,
  ],
  templateUrl: './home-page.component.html',
  styleUrl: './home-page.component.scss',
})
export class HomePageComponent {
  formGroup = NewCreateShortUrlForm();

  constructor(private shortUrlsApi: ShortUrlApiService) {}

  onSubmit(event: Event): void {
    event.preventDefault();

    const originalUrl = this.getShortUrl();
    if (!this.formGroup.valid) {
      console.warn('form is not valid');
      return;
    } else if (!originalUrl) {
      console.warn(`originalUrl ${originalUrl} is not valid`);
      return;
    }

    this.shortUrlsApi.createShortUrl(originalUrl).subscribe({
      error(err) {
        console.error(err);
      },
      next(response) {
        console.log(response);
      },
    });
  }

  private getShortUrl() {
    return this.formGroup.value.original_url;
  }
}

export interface CreateShortUrlRequest {
  original_url: string;
}

export function NewCreateShortUrlForm() {
  return new FormGroup({
    original_url: new FormControl<string | null>(null, [Validators.required]),
  });
}
