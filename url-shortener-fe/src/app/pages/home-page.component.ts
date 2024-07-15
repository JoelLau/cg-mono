import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { ShortUrlApiService } from '../services/short-url-api/short-url-api.service';
import { FormGroup, Validators } from '@angular/forms';
import { StackLayoutComponent } from '../layouts/stack-layout.component';

@Component({
  selector: 'app-home-page',
  standalone: true,
  imports: [CommonModule, StackLayoutComponent],
  templateUrl: './home-page.component.html',
  styleUrl: './home-page.component.scss',
})
export class HomePageComponent {
  formGroup = NewCreateShortUrlForm()

  constructor(private shortUrlsApi: ShortUrlApiService) { }

  onSubmit(event: Event): void {
    event.preventDefault()

    if (this.formGroup.valid && this.formGroup.value.original_url) {
      this.shortUrlsApi.createShortUrl(this.formGroup.value.original_url)
      .subscribe({
        error(err) { console.error(err) },
        next(response) { console.log(response) }
      })
    }
  }
}



export interface CreateShortUrlRequest {
  original_url: string
}


export function NewCreateShortUrlForm() {
  return new FormGroup({
    original_url: new FormGroup('', [Validators.required])
  })
}
